package admin

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/nfnt/resize"
	uuid "github.com/satori/go.uuid"
	"go-shop-b2c/common/http"
	"go-shop-b2c/model_views"
	"go-shop-b2c/setting"
	"image"
	"image/gif"
	"image/jpeg"
	"image/png"
	"io"
	"mime/multipart"
	"os"
	"path/filepath"
	"strconv"
	"strings"
)

type UploadController struct {
	BaseController
}

// URLMapping ...
func (c *UploadController) URLMapping() {
	c.Mapping("Upload", c.Upload)
}

/**
 * Large、Medium、Thumbnail三种图片的宽高
 */
type imageSize struct {
	Large     Image
	Medium    Image
	Thumbnail Image
}

type Image struct {
	Width  uint
	Height uint
}

// @Title Upload Image by three size
// @router / [post]
func (c *UploadController) Upload() {
	/**
	 * 获取 Large、Medium、Thumbnail的宽高
	 */
	size := imageSize{}
	if lWidth, _ := setting.GetValueByKey("largeProductImageWidth"); lWidth != "" {
		width, _ := strconv.Atoi(lWidth)
		size.Large.Width = uint(width)
	}
	if lHeight, _ := setting.GetValueByKey("largeProductImageHeight"); lHeight != "" {
		height, _ := strconv.Atoi(lHeight)
		size.Large.Height = uint(height)
	}

	if mWidth, _ := setting.GetValueByKey("mediumProductImageWidth"); mWidth != "" {
		width, _ := strconv.Atoi(mWidth)
		size.Medium.Width = uint(width)
	}
	if mHeight, _ := setting.GetValueByKey("mediumProductImageHeight"); mHeight != "" {
		height, _ := strconv.Atoi(mHeight)
		size.Medium.Height = uint(height)
	}

	if tWidth, _ := setting.GetValueByKey("thumbnailProductImageWidth"); tWidth != "" {
		width, _ := strconv.Atoi(tWidth)
		size.Thumbnail.Width = uint(width)
	}
	if tHeight, _ := setting.GetValueByKey("thumbnailProductImageHeight"); tHeight != "" {
		height, _ := strconv.Atoi(tHeight)
		size.Thumbnail.Height = uint(height)
	}

	fileData, fileHeader, err := c.GetFile("upload")
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 保存原图
	 */
	u, name := c.saveSourceImage(fileData, fileHeader)

	/**
	 * 压缩,PS: 只能保存原图之后才能压缩
	 */
	/**
	 * 保存到数据的图片没有不需要 app.conf 的 image参数
	 * 但实际图片存储于服务器于 beego.AppConfig.String("image") 的目录下
	 */
	_, appFilePathStr := getImagePathStr(name)

	file, err := os.Open(appFilePathStr)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "图片上传路径有误")
		return
	}

	var view model_views.Image
	fileExt := filepath.Ext(fileHeader.Filename)
	/**
	 * 根据不同的图片, 调用不同的解码
	 */
	switch fileExt {
	case ".jpg", ".jpeg":
		// decode jpeg into image.Image
		img, err := jpeg.Decode(file)
		if err != nil {
			c.ServerError(err)
			return
		}
		_ = file.Close()

		view, err = saveLargeMediumThumbnail(u, &size, img, func(out *os.File, image image.Image) {
			// write new image to file
			err = jpeg.Encode(out, image, nil)
		})
		if err != nil {
			c.ServerError(err)
			return
		}
		break
	case ".png":
		// decode png into image.Image
		img, err := png.Decode(file)
		if err != nil {
			c.ServerError(err)
			return
		}
		_ = file.Close()

		view, err = saveLargeMediumThumbnail(u, &size, img, func(out *os.File, image image.Image) {
			// write new image to file
			err = png.Encode(out, image)
		})
		if err != nil {
			c.ServerError(err)
			return
		}
		break
	case ".gif":
		// decode png into image.Image
		img, err := gif.Decode(file)
		if err != nil {
			c.ServerError(err)
			return
		}
		_ = file.Close()

		view, err = saveLargeMediumThumbnail(u, &size, img, func(out *os.File, image image.Image) {
			// write new image to file
			err = gif.Encode(out, image, nil)
		})
		if err != nil {
			c.ServerError(err)
			return
		}
		break
	}

	var imageList []model_views.Image
	imageList = append(imageList, view)

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, imageList)
}

func (c *UploadController) saveSourceImage(fileData multipart.File, fileHeader *multipart.FileHeader) (uid uuid.UUID, name string) {

	fileType := "other"
	/**
	 * 判断后缀为图片的文件，如果是图片我们才存入到数据库中
	 */
	fileExt := filepath.Ext(fileHeader.Filename)
	if fileExt == ".jpg" || fileExt == ".png" || fileExt == ".gif" || fileExt == ".jpeg" {
		fileType = "image"
	}
	if fileType == "other" {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "仅支持 jpg/png/gif/jpeg 格式")
		return
	}

	/**
	 * 文件夹路径
	 */
	_, appFileDir := getImageDir()

	/**
	 * ModePerm是0777，这样拥有该文件夹路径的执行权限
	 */
	err := os.MkdirAll(appFileDir, os.ModePerm)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 文件名称、文件路径
	 */
	u := uuid.Must(uuid.NewV4(), nil)
	name = generateImageName(u, "source", "png")
	_, appFilePathStr := getImagePathStr(name)
	desFile, err := os.Create(appFilePathStr)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 将浏览器客户端上传的文件拷贝到本地路径的文件里面
	 */
	_, err = io.Copy(desFile, fileData)
	if err != nil {
		c.ServerError(err)
		return
	}

	return u, name
}

func getImageDir() (saveFileDir string, appFileDir string) {
	/**
	 * 文件夹路径
	 */
	saveFileDir, _ = setting.ResolveImageUploadPath()
	appFileDir = beego.AppConfig.String("image") + saveFileDir

	return saveFileDir, appFileDir
}

/**
 * 保存图片 large、medium、thumbnail
 */
func saveLargeMediumThumbnail(u uuid.UUID, size *imageSize, img image.Image, callback func(out *os.File, image image.Image)) (view model_views.Image, err error) {
	view.Uid = u

	/**
	 * Source
	 */
	name := generateImageName(u, "source", "png")
	saveFilePathStr, _ := getImagePathStr(name)
	saveFilePathStr = strings.Replace(saveFilePathStr, "\\", "/", -1)
	view.Source = saveFilePathStr
	view.Url = saveFilePathStr
	view.Name = name
	view.Status = "done"

	/**
	 * Large
	 */
	name = generateImageName(u, "large", "png")
	saveFilePathStr, appFilePathStr := getImagePathStr(name)
	err = saveImageFile(appFilePathStr, img, size.Large.Width, size.Large.Height, func(out *os.File, image image.Image) {
		callback(out, image)
	})
	saveFilePathStr = strings.Replace(saveFilePathStr, "\\", "/", -1)
	view.Large = saveFilePathStr
	view.Name = name
	view.Status = "done"

	/**
	 * Medium
	 */
	name = generateImageName(u, "medium", "png")
	saveFilePathStr, appFilePathStr = getImagePathStr(name)
	err = saveImageFile(appFilePathStr, img, size.Medium.Width, size.Medium.Height, func(out *os.File, image image.Image) {
		callback(out, image)
	})
	saveFilePathStr = strings.Replace(saveFilePathStr, "\\", "/", -1)
	view.Medium = saveFilePathStr
	view.Name = name
	view.Status = "done"

	/**
	 * Thumbnail
	 */
	name = generateImageName(u, "thumbnail", "png")
	saveFilePathStr, appFilePathStr = getImagePathStr(name)
	err = saveImageFile(appFilePathStr, img, size.Thumbnail.Width, size.Thumbnail.Height, func(out *os.File, image image.Image) {
		callback(out, image)
	})
	saveFilePathStr = strings.Replace(saveFilePathStr, "\\", "/", -1)
	view.ThumbUrl = saveFilePathStr
	view.Name = name
	view.Status = "done"

	return view, err
}

/**
 * 生成图片名称
 */
func generateImageName(u uuid.UUID, size string, types string) (name string) {
	name = fmt.Sprintf("%s-%s.%s", u, size, types)
	return name
}

/**
 * 获取图片的 path
 */
func getImagePathStr(name string) (saveFilePathStr string, appFilePathStr string) {
	saveFileDir, appFileDir := getImageDir()

	saveFilePathStr = filepath.Join(saveFileDir, name)
	appFilePathStr = filepath.Join(appFileDir, name)
	return saveFilePathStr, appFilePathStr
}

/**
 * 保存图片
 */
func saveImageFile(filePathStr string, img image.Image, width uint, height uint, callback func(out *os.File, image image.Image)) error {
	// resize to width 1000 using Lanczos resampling
	// and preserve aspect ratio
	m := resize.Resize(width, height, img, resize.Lanczos3)
	out, err := os.Create(filePathStr)
	if err != nil {
		return err
	}
	defer out.Close()

	callback(out, m)
	return err
}

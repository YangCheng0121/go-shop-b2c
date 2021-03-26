package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type AdController struct {
	BaseController
}

// URLMapping ...
func (c *AdController) URLMapping() {
	c.Mapping("AddAd", c.AddAd)
	c.Mapping("DeleteAd", c.DeleteAd)
	c.Mapping("UpdateAd", c.UpdateAd)
	c.Mapping("GetAd", c.GetAd)
	c.Mapping("GetAllAdPosition", c.GetAllAdPosition)
	c.Mapping("GetAllAd", c.GetAllAd)
}

// @Title Add Ad
// @router /add [post]
func (c *AdController) AddAd() {
	var ad model_views.Ad

	if v := c.GetString("ad"); v != "" {
		_ = json.Unmarshal([]byte(v), &ad)
	}

	var adModel models.Ad
	adModel.Id = ad.Id
	adModel.Title = ad.Title
	adModel.Orders = ad.Orders
	adModel.BeginDate = ad.BeginDate
	adModel.EndDate = ad.EndDate
	adModel.Type = ad.Type
	adModel.Content = ad.Content
	adModel.Url = ad.Url
	adModel.AdPositionId = ad.AdPositionId
	adModel.Path = ad.Path
	adModel.CreateBy = c.Admin.Username

	_, err := models.AddAd(&adModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Ad
// @router /delete [delete]
func (c *AdController) DeleteAd() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		err := models.DeleteAd(id)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Ad
// @router /update [put]
func (c *AdController) UpdateAd() {
	var ad model_views.Ad

	if v := c.GetString("ad"); v != "" {
		_ = json.Unmarshal([]byte(v), &ad)
	}

	adModel, err := models.GetAdById(ad.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	adModel.Id = ad.Id
	adModel.Title = ad.Title
	adModel.Orders = ad.Orders
	adModel.BeginDate = ad.BeginDate
	adModel.EndDate = ad.EndDate
	adModel.Type = ad.Type
	adModel.Content = ad.Content
	adModel.Url = ad.Url
	adModel.AdPositionId = ad.AdPositionId
	adModel.Path = ad.Path
	adModel.LastUpdatedBy = c.Admin.Username

	err = models.UpdateAdById(adModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Area
// @router /:id
func (c *AdController) GetAd() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	ad, err := models.GetAdById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
		return
	}
	adView := c.setAdByAdModel(*ad)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, adView)
}

// @Title Get All AdPosition
// @router /ad_position [get]
func (c *AdController) GetAllAdPosition() {
	var query = make(map[string]string)

	query["DeleteFlag"] = "0"
	cnt, err := models.GetAdPositionCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllAdPosition(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		adPosition := v.(models.AdPosition)
		adPositionView := c.setAdPositionByAdPositionModel(adPosition)

		list = append(list, adPositionView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title GetAllAd
// @Description Get all ad by some filed
// @router / [get]
func (c *AdController) GetAllAd() {
	var sortby []string
	var order []string
	var query = make(map[string]string)
	var pageSize int64 = 10
	var pageNumber int64 = 1

	// sortby: col1,col2
	if v := c.GetString("sortby"); v != "" {
		sortby = strings.Split(v, ",")
	}
	// order: desc,asc
	if v := c.GetString("order"); v != "" {
		order = strings.Split(v, ",")
	}
	// query: k:v,k:v
	if v := c.GetString("query"); v != "" {
		for _, cond := range strings.Split(v, ",") {
			kv := strings.SplitN(cond, ":", 2)
			if len(kv) != 2 {
				c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, "fail", "Error: invalid query key/value pair")
				return
			}
			k, v := kv[0], kv[1]
			query[k] = v
		}
	}
	// pageNumber: 1 (default is 1)
	if v := c.GetString("pageNumber"); v != "" {
		pageNumber, _ = strconv.ParseInt(v, 10, 64)
	}
	// pageSize: 10 (default is 10)
	if v := c.GetString("pageSize"); v != "" {
		pageSize, _ = strconv.ParseInt(v, 10, 64)
	}

	// start position of result set
	offset := (pageNumber - 1) * pageSize

	l, err := models.GetAllAd(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetAdCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		ad := v.(models.Ad)
		adView := c.setAdByAdModel(ad)
		pageList = append(pageList, adView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *AdController) setAdByAdModel(ad models.Ad) (adView model_views.Ad) {
	adView.Id = ad.Id
	adView.Title = ad.Title
	adView.Orders = ad.Orders
	adView.BeginDate = ad.BeginDate
	adView.EndDate = ad.EndDate
	adView.Type = ad.Type
	adView.Content = ad.Content
	adView.Url = ad.Url

	position, err := models.GetAdPositionById(int(ad.AdPositionId))
	if err != nil {
		c.ServerError(err)
		return
	}
	adView.AdPositionId = int64(position.Id)
	adView.AdPosition = position.Name
	adView.Path = ad.Path

	return adView
}

func (c *AdController) setAdPositionByAdPositionModel(adPosition models.AdPosition) (adPositionView model_views.AdPosition) {
	adPositionView.Id = adPosition.Id
	adPositionView.Name = adPosition.Name
	adPositionView.Description = adPosition.Description
	adPositionView.Width = adPosition.Width
	adPositionView.Height = adPosition.Height
	adPositionView.Template = adPosition.Template

	return adPositionView
}

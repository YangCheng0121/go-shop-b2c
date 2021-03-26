package web

import (
	"go-shop-b2c/common/http"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"time"
)

type IndexController struct {
	JsonController
}

// URLMapping ...
func (c *IndexController) URLMapping() {
	c.Mapping("GetData", c.GetData)
	c.Mapping("GetBanner", c.GetBanner)
}

// @router / [get]
func (c *IndexController) GetData() {
	var sortby []string
	var order []string

	/**
	 * 获取置顶分类
	 */
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["IsTop"] = "1"
	query["IsShow"] = "1"
	query["IsMarketable"] = "1"

	cnt, err := models.GetProductCategoryCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllProductCategory(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 获取置顶分类的置顶商品
	 * 首页只返回 6 个置顶商品
	 */
	sortby = append(sortby, "LastUpdatedDate")
	order = append(order, "desc")

	var list []interface{}
	for _, v := range l {
		productCategory := v.(models.ProductCategory)
		productCategoryView := c.setProductCategoryViewByProductCategoryModel(productCategory)

		var query = make(map[string]string)
		query["IsTop"] = "1"
		query["IsList"] = "1"
		query["IsMarketable"] = "1"
		query["ProductCategoryId"] = strconv.Itoa(productCategory.Id)
		l, err := models.GetAllProduct(query, nil, sortby, order, 0, 6)
		if err != nil {
			c.ServerError(err)
			return
		}

		for _, v := range l {
			product := v.(models.Product)
			if product.ProductCategoryId.Id == productCategory.Id {
				controller := CommonController{}
				productView := controller.SetProductViewByProductModel(product)
				productCategoryView.Products = append(productCategoryView.Products, productView)
			}
		}

		list = append(list, productCategoryView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @router /banner [get]
func (c *IndexController) GetBanner() {
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["AdPositionId"] = "3"
	// query["IsTop"] = "1"
	// query["IsList"] = "1"
	// query["IsMarketable"] = "1"
	query["EndDate__gt"] = time.Now().Format("2006-01-02 15:04:05")

	cnt, err := models.GetAdCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	ads, err := models.GetAllAd(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range ads {
		ad := v.(models.Ad)
		adView := c.setAdByAdModel(ad)

		list = append(list, adView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

/**
 * ProductCategoryModel 转为 ProductCategoryView
 */
func (c *IndexController) setProductCategoryViewByProductCategoryModel(productCategory models.ProductCategory) (productCategoryView model_views.ProductCategoryProducts) {
	productCategoryView.Id = productCategory.Id
	productCategoryView.Name = productCategory.Name
	productCategoryView.Orders = productCategory.Orders
	productCategoryView.Grade = productCategory.Grade
	if productCategory.ParentId != nil {
		productCategoryView.ParentId = productCategory.ParentId
	} else {
		productCategoryView.ParentId = nil
	}
	productCategoryView.Image = productCategory.Image
	productCategoryView.TreePath = productCategory.TreePath
	productCategoryView.DeleteFlag = productCategory.DeleteFlag

	return productCategoryView
}

/**
 * AdModel 转为 AdView
 */
func (c *IndexController) setAdByAdModel(ad models.Ad) (adView model_views.Ad) {
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

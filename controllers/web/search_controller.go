package web

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/models"
	"bee-shop-b2c/setting"
	"strconv"
	"strings"
)

type SearchController struct {
	BaseController
}

// URLMapping ...
func (c *SearchController) URLMapping() {
	c.Mapping("Search", c.Search)
	c.Mapping("HotSearch", c.HotSearch)
}

// @Title 搜索
// @router /
func (c *SearchController) Search() {
	var sortby []string
	var keyword string
	var productCategoryId string
	var order []string
	var query = make(map[string]string)
	var pageSize int64 = 10
	var pageNumber int64 = 1

	// sortby: col1,col2
	if v := c.GetString("sortby"); v != "" {
		sortby = strings.Split(v, ",")
	}
	// keyword
	if v := c.GetString("keyword"); v != "" {
		keyword = v
	}
	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId = v
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

	query["DeleteFlag"] = "0"
	if keyword != "" {
		query["Name__icontains"] = keyword
	}
	if productCategoryId != "" {
		query["productCategoryId"] = productCategoryId
	}

	// start position of result set
	offset := (pageNumber - 1) * pageSize

	products, err := models.GetAllProduct(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range products {
		product := v.(models.Product)
		controller := CommonController{}
		productView := controller.SetProductViewByProductModel(product)
		pageList = append(pageList, productView)
	}

	cnt, err := models.GetProductCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

// @Title 热门搜索
// @router /hot
func (c *SearchController) HotSearch() {
	hotSearch, err := setting.GetValueByKey("hotSearch")
	if err != nil {
		c.ServerError(err)
		return
	}
	hotSearchArr := strings.Split(hotSearch, ",")

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, hotSearchArr)
}

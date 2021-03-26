package admin

import (
	"go-shop-b2c/common/http"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type SkuController struct {
	BaseController
}

// URLMapping ...
func (c *SkuController) URLMapping() {
	c.Mapping("GetSku", c.GetSku)
	c.Mapping("GetAllSku", c.GetAllSku)
}

// @Title Get SKU
// @router /:sn
func (c *SkuController) GetSku() {
	snStr := c.Ctx.Input.Param(":sn")

	sku, err := models.GetSkuBySn(snStr)
	if err != nil {
		c.ServerError(err)
		return
	}
	skuView := c.setSkuViewBySkuModel(sku)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, skuView)
}

// @Title Get All Sku
// @Description get all Sku
// @Param	query		query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields		query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	sortby		query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order		query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ..."
// @Param	pageSize	query	string	false	"PageSize the size of result set. Must be an integer"
// @Param	offset		query	string	false	"Start position of result set. Must be an integer"
// @router / [get]
func (c *SkuController) GetAllSku() {
	var sortby []string
	var order []string
	var query = make(map[string]string)
	var pageNumber int64 = 1
	var pageSize int64 = 10

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

	query["DeleteFlag"] = "0"
	if query["Name__icontains"] != "" {
		skus, err := models.GetSkuByProductName(query["Name__icontains"])
		if err != nil {
			c.ServerError(err)
			return
		}

		var pageList []interface{}
		for _, sku := range skus {
			skuView := c.setSkuViewBySkuModel(&sku)
			pageList = append(pageList, skuView)
		}

		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pageList)
	} else {
		cnt, err := models.GetSkuCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}
		skus, err := models.GetAllSku(query, nil, sortby, order, offset, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}

		var pageList []interface{}
		for _, sku := range skus {
			sku := sku.(models.Sku)
			skuView := c.setSkuViewBySkuModel(&sku)
			pageList = append(pageList, skuView)
		}

		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pageList)
	}
}

func (c *SkuController) setSkuViewBySkuModel(sku *models.Sku) (skuView model_views.Sku) {
	skuView.Id = sku.Id
	skuView.Sn = sku.Sn
	skuView.AllocatedStock = sku.AllocatedStock
	skuView.Stock = sku.Stock
	skuView.Price = sku.Price
	skuView.MarketPrice = sku.MarketPrice
	skuView.Cost = sku.Cost
	skuView.IsEnable = sku.IsEnable
	skuView.IsDefault = sku.IsDefault
	skuView.SpecificationValues = sku.SpecificationValues

	product, err := models.GetProductById(sku.ProductId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	skuView.ProductId = product.Id
	skuView.Name = product.Name

	return skuView
}

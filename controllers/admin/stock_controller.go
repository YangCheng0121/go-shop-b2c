package admin

import (
	"bee-shop-b2c/common/http"
	stockHelper "bee-shop-b2c/common/stock"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"strconv"
	"strings"
)

type StockController struct {
	BaseController
}

// URLMapping ...
func (c *StockController) URLMapping() {
	c.Mapping("InStock", c.InStock)
	c.Mapping("OutStock", c.OutStock)
}

// @Title In Stock
// @router /in [post]
func (c *StockController) InStock() {
	var sn string
	var inQuantity int
	var memo string

	// sn
	if v := c.GetString("sn"); v != "" {
		sn = v
	}
	// inQuantity
	if v := c.GetString("in_quantity"); v != "" {
		inQuantity, _ = strconv.Atoi(v)
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}

	sku, err := models.GetSkuBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	stock := sku.Stock + inQuantity
	sku.Stock = stock

	var stockLog models.StockLog
	stockLog.Stock = stock
	stockLog.Memo = memo
	stockLog.SkuId = &models.Sku{Id: sku.Id}
	stockLog.InQuantity = inQuantity
	if stockType := stockHelper.GetStockTypeByAlias("in"); stockType > -1 {
		stockLog.Type = stockType
	}

	stockLog.CreateBy = c.Admin.Name
	_, err = models.AddStockLog(&stockLog)
	if err != nil {
		c.ServerError(err)
		return
	}

	sku.LastUpdatedBy = c.Admin.Name
	err = models.UpdateSkuById(sku)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Out Stock
// @router /out [post]
func (c *StockController) OutStock() {
	var sn string
	var outQuantity int
	var memo string

	// sn
	if v := c.GetString("sn"); v != "" {
		sn = v
	}
	// outQuantity
	if v := c.GetString("out_quantity"); v != "" {
		outQuantity, _ = strconv.Atoi(v)
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}

	sku, err := models.GetSkuBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	stock := sku.Stock - outQuantity
	sku.Stock = stock

	var stockLog models.StockLog
	stockLog.Stock = stock
	stockLog.Memo = memo
	stockLog.SkuId = &models.Sku{Id: sku.Id}
	stockLog.OutQuantity = outQuantity
	stockLog.CreateBy = c.Admin.Name
	if stockType := stockHelper.GetStockTypeByAlias("out"); stockType > -1 {
		stockLog.Type = stockType
	}

	_, err = models.AddStockLog(&stockLog)
	if err != nil {
		c.ServerError(err)
		return
	}

	sku.LastUpdatedBy = c.Admin.Name
	err = models.UpdateSkuById(sku)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title GetAllStock
// @Description Get all stock list by some filed
// @Param	query	    query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	sortby	    query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order	    query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ...
// @Param	pageNumber	query	string	false	"Start position of result set. Must be an integer"
// @Param	pageSize	query	int	    false	"Limit the size of result set. Must be an integer"
// @router  /log [get]
// @Success 200 {object} model_views.StockLog
// @Failure 500
func (c *StockController) GetAllStock() {
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

	if query["Sn"] != "" {
		sku, err := models.GetSkuBySn(query["Sn"])
		if err != nil {
			c.ServerError(err)
			return
		}
		query["SkuId"] = strconv.Itoa(sku.Id)
		delete(query, "Sn")
	}

	query["DeleteFlag"] = "0"
	l, err := models.GetAllStockLog(query, nil, sortby, order, 0, offset)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, stockLog := range l {
		stockLog := stockLog.(models.StockLog)
		stockLogView := &model_views.StockLog{}
		stockLogView.Id = stockLog.Id
		stockLogView.Stock = stockLog.Stock
		stockLogView.Type = stockHelper.GetStockTypeByAliasName(stockLog.Type)
		stockLogView.InQuantity = stockLog.InQuantity
		stockLogView.OutQuantity = stockLog.OutQuantity
		stockLogView.Memo = stockLog.Memo
		stockLogView.CreationDate = stockLog.CreationDate

		sku, err := models.GetSkuById(stockLog.SkuId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		stockLogView.Sku = &model_views.Sku{}
		stockLogView.Sku.Id = sku.Id
		stockLogView.Sku.Stock = sku.Stock
		stockLogView.Sku.AllocatedStock = sku.AllocatedStock
		stockLogView.Sku.Sn = sku.Sn
		stockLogView.Sku.Price = sku.Price
		stockLogView.Sku.Cost = sku.Cost
		stockLogView.Sku.MarketPrice = sku.MarketPrice
		stockLogView.Sku.ExchangePoint = sku.ExchangePoint
		stockLogView.Sku.SpecificationValues = sku.SpecificationValues
		stockLogView.Sku.IsDefault = sku.IsDefault
		stockLogView.Sku.IsEnable = sku.IsEnable

		product, err := models.GetProductById(sku.ProductId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		stockLogView.Sku.Name = product.Name

		pageList = append(pageList, stockLogView)
	}

	cnt, err := models.GetStockLogCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	pages, _ := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

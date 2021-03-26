package admin

import (
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type ReturnsController struct {
	BaseController
}

// URLMapping ...
func (c *ReturnsController) URLMapping() {
	c.Mapping("GetReturnsByOrder", c.GetReturnsByOrder)
	c.Mapping("GetOneReturns", c.GetOneReturns)
	c.Mapping("GetAllReturns", c.GetAllReturns)
}

// @Title Get Returns
// @router /order [get]
func (c *ReturnsController) GetReturnsByOrder() {
	var orderId string
	var sortby []string
	var order []string

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId = v
	}
	// sortby: col1,col2
	if v := c.GetString("sortby"); v != "" {
		sortby = strings.Split(v, ",")
	}
	// order: desc,asc
	if v := c.GetString("order"); v != "" {
		order = strings.Split(v, ",")
	}

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["OrderId"] = orderId

	cnt, err := models.GetReturnsCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllReturns(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		Returns := v.(models.Returns)
		ReturnsView := c.setReturnsByReturnsModel(Returns)

		list = append(list, ReturnsView)
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get One Returns
// @router /:sn
func (c *ReturnsController) GetOneReturns() {
	sn := c.Ctx.Input.Param(":sn")

	Returns, err := models.GetReturnsBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	ReturnsView := c.setReturnsByReturnsModel(*Returns)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, ReturnsView)
}

// @Title Get All Returns
// @router / [get]
func (c *ReturnsController) GetAllReturns() {
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

	query["DeleteFlag"] = "0"
	l, err := models.GetAllReturns(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		Returns := v.(models.Returns)
		ReturnsView := c.setReturnsByReturnsModel(Returns)
		pageList = append(pageList, ReturnsView)
	}

	cnt, err := models.GetReturnsCount(query)
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

func (c *ReturnsController) setReturnsByReturnsModel(Returns models.Returns) (ReturnsView model_views.Returns) {
	ReturnsView.Id = Returns.Id
	ReturnsView.Sn = Returns.Sn

	order, err := models.GetOrderById(Returns.OrderId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	ReturnsView.OrderId = order.Id
	ReturnsView.OrderSn = order.Sn

	ReturnsView.DeliveryCorp = Returns.DeliveryCorp
	ReturnsView.ZipCode = Returns.ZipCode
	ReturnsView.Area = Returns.Area
	ReturnsView.Address = Returns.Address
	ReturnsView.TrackingNo = Returns.TrackingNo
	ReturnsView.Shipper = Returns.ShippingMethod
	ReturnsView.Operator = Returns.Operator
	ReturnsView.Phone = Returns.Phone
	ReturnsView.Freight = Returns.Freight
	ReturnsView.Memo = Returns.Memo
	ReturnsView.ShippingMethod = Returns.ShippingMethod
	ReturnsView.CreationDate = Returns.CreationDate

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ReturnsId"] = strconv.Itoa(Returns.Id)

	cnt, err := models.GetReturnsItemCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllReturnsItem(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range l {
		ReturnsItem := v.(models.ReturnsItem)
		ReturnsItemView := &model_views.ReturnsItem{}
		ReturnsItemView.Id = ReturnsItem.Id
		ReturnsItemView.ReturnsId = ReturnsItem.ReturnsId.Id
		ReturnsItemView.Sn = ReturnsItem.Sn
		ReturnsItemView.Quantity = ReturnsItem.Quantity
		ReturnsItemView.Name = ReturnsItem.Name

		ReturnsView.Items = append(ReturnsView.Items, *ReturnsItemView)
	}

	return ReturnsView
}

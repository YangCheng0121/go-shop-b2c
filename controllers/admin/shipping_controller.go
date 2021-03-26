package admin

import (
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type ShippingController struct {
	BaseController
}

// URLMapping ...
func (c *ShippingController) URLMapping() {
	c.Mapping("GetShippingByOrder", c.GetShippingByOrder)
	c.Mapping("GetOneShipping", c.GetOneShipping)
	c.Mapping("GetAllShipping", c.GetAllShipping)
}

// @Title Get Shipping
// @router /order [get]
func (c *ShippingController) GetShippingByOrder() {
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

	cnt, err := models.GetShippingCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllShipping(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		shipping := v.(models.Shipping)
		shippingView := c.setShippingByShippingModel(shipping)

		list = append(list, shippingView)
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get One Shipping
// @router /:sn
func (c *ShippingController) GetOneShipping() {
	sn := c.Ctx.Input.Param(":sn")

	shipping, err := models.GetShippingBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	shippingView := c.setShippingByShippingModel(*shipping)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, shippingView)
}

// @Title Get All Shipping
// @router / [get]
func (c *ShippingController) GetAllShipping() {
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
	l, err := models.GetAllShipping(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		shipping := v.(models.Shipping)
		shippingView := c.setShippingByShippingModel(shipping)
		pageList = append(pageList, shippingView)
	}

	cnt, err := models.GetShippingCount(query)
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

func (c *ShippingController) setShippingByShippingModel(shipping models.Shipping) (shippingView model_views.Shipping) {
	shippingView.Id = shipping.Id
	shippingView.Sn = shipping.Sn

	order, err := models.GetOrderById(int(shipping.OrderId))
	if err != nil {
		c.ServerError(err)
		return
	}
	shippingView.OrderId = int64(order.Id)
	shippingView.OrderSn = order.Sn

	shippingView.DeliveryCorp = shipping.DeliveryCorp
	shippingView.DeliveryCorpCode = shipping.DeliveryCorpCode
	shippingView.DeliveryCorpUrl = shipping.DeliveryCorpUrl
	shippingView.ZipCode = shipping.ZipCode
	shippingView.Area = shipping.Area
	shippingView.Address = shipping.Address
	shippingView.TrackingNo = shipping.TrackingNo
	shippingView.Consignee = shipping.Consignee
	shippingView.Operator = shipping.Operator
	shippingView.Phone = shipping.Phone
	shippingView.Freight = shipping.Freight
	shippingView.Memo = shipping.Memo
	shippingView.ShippingMethod = shipping.ShippingMethod
	shippingView.CreationDate = shipping.CreationDate
	shippingView.CreateBy = shipping.CreateBy

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ShippingId"] = strconv.Itoa(shipping.Id)

	cnt, err := models.GetShippingItemCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllShippingItem(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range l {
		shippingItem := v.(models.ShippingItem)
		shippingItemView := &model_views.ShippingItem{}
		shippingItemView.Id = shippingItem.Id
		shippingItemView.ShippingId = shippingItem.ShippingId.Id
		shippingItemView.Sn = shippingItem.Sn
		shippingItemView.Quantity = shippingItem.Quantity
		shippingItemView.Name = shippingItem.Name
		shippingItemView.IsDelivery = shippingItem.IsDelivery

		shippingView.Items = append(shippingView.Items, *shippingItemView)
	}

	return shippingView
}

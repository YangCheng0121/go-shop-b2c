package admin

import (
	"go-shop-b2c/common/http"
	paymentHelper "go-shop-b2c/common/payment"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type PaymentController struct {
	BaseController
}

// URLMapping ...
func (c *PaymentController) URLMapping() {
	c.Mapping("GetPaymentByOrder", c.GetPaymentByOrder)
	c.Mapping("GetOnePayment", c.GetOnePayment)
	c.Mapping("GetAllPayment", c.GetAllPayment)
}

// @Title Get Payment By Order
// @router /order [get]
func (c *PaymentController) GetPaymentByOrder() {
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

	cnt, err := models.GetPaymentCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllPayment(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		payment := v.(models.Payment)
		paymentView := c.setPaymentByPaymentModel(payment)
		list = append(list, paymentView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get One Payment
// @router /:sn
func (c *PaymentController) GetOnePayment() {
	sn := c.Ctx.Input.Param(":sn")

	payment, err := models.GetPaymentBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	paymentView := c.setPaymentByPaymentModel(*payment)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, paymentView)
}

// @Title Get All DeliveryCorp
// @router / [get]
func (c *PaymentController) GetAllPayment() {
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
	l, err := models.GetAllPayment(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		payment := v.(models.Payment)
		paymentView := c.setPaymentByPaymentModel(payment)
		pageList = append(pageList, paymentView)
	}

	cnt, err := models.GetPaymentCount(query)
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

/*
 * PaymentModel 转为 PaymentView
 */
func (c *PaymentController) setPaymentByPaymentModel(payment models.Payment) (paymentView model_views.Payment) {
	paymentView.Id = payment.Id
	paymentView.Sn = payment.Sn

	order, err := models.GetOrderById(int(payment.OrderId))
	if err != nil {
		c.ServerError(err)
		return
	}
	paymentView.OrderId = int64(order.Id)
	paymentView.OrderSn = order.Sn

	paymentView.Memo = payment.Memo
	paymentView.Method = payment.Method
	paymentView.MethodName = paymentHelper.GetPaymentMethodName(payment.Method)
	paymentView.PaymentMethod = payment.PaymentMethod
	paymentView.MemberId = payment.MemberId
	paymentView.Fee = payment.Fee
	paymentView.Expire = payment.Expire
	paymentView.Amount = payment.Amount
	paymentView.Operator = payment.Operator
	paymentView.Payer = payment.Payer
	paymentView.PaymentDate = payment.PaymentDate
	paymentView.PaymentPluginId = payment.PaymentPluginId
	paymentView.CreationDate = payment.CreationDate

	return paymentView
}

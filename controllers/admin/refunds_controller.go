package admin

import (
	"bee-shop-b2c/common"
	"bee-shop-b2c/common/http"
	orderHelper "bee-shop-b2c/common/order"
	paymentHelper "bee-shop-b2c/common/payment"
	refundHelper "bee-shop-b2c/common/refund"
	"bee-shop-b2c/common/weixin"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	wechatPayRefund "github.com/silenceper/wechat/v2/pay/refund"
	"strconv"
	"strings"
)

type RefundsController struct {
	BaseController
}

// URLMapping ...
func (c *RefundsController) URLMapping() {
	c.Mapping("ReviewRefund", c.ReviewRefund)
	c.Mapping("GetRefundsByOrder", c.GetRefundsByOrder)
	c.Mapping("GetOneRefunds", c.GetOneRefunds)
	c.Mapping("GetAllRefunds", c.GetAllRefunds)
}

// @Title Confirm Refund
// @router /review [put]
func (c *RefundsController) ReviewRefund() {
	var sn string
	var review int
	// sn
	if v := c.GetString("sn"); v != "" {
		sn = v
	}
	// review
	if v := c.GetString("review"); v != "" {
		review, _ = strconv.Atoi(v)
	}

	refund, err := models.GetRefundsBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	order, err := models.GetOrderById(refund.OrderId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	if review == 1 {
		payRefund := weixin.GetPayRefund()
		params := &wechatPayRefund.Params{}
		params.OutRefundNo = order.Sn
		params.OutRefundNo = refund.Sn
		params.TotalFee = weixin.GetTotalFree(order.Amount)
		params.RefundFee = weixin.GetTotalFree(refund.Amount)
		params.RootCa = common.GetApiKey()

		resp, err := payRefund.Refund(params)
		if err != nil {
			c.ServerError(err)
			return
		}

		if resp.ReturnCode == "SUCCESS" {
			/**
			 * 更新订单状态
			 */
			order.Status = orderHelper.GetOrderStatusByAlias("refunded")
			err = models.UpdateOrderById(order)
			if err != nil {
				c.ServerError(err)
				return
			}
			refund.IsReview = refundHelper.GetRefundReviewByAlias("allow")
			err = models.UpdateRefundsById(refund)
			if err != nil {
				c.ServerError(err)
				return
			}

			c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, "订单退款审核通过!")
		} else {
			c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, resp.ErrCodeDes)
		}
	} else {
		refund.IsReview = refundHelper.GetRefundReviewByAlias("reject")
		err = models.UpdateRefundsById(refund)
		if err != nil {
			c.ServerError(err)
			return
		}
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "订单退款审核拒绝成功!")
	}
}

// @Title Get Refunds
// @router /order [get]
func (c *RefundsController) GetRefundsByOrder() {
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

	cnt, err := models.GetRefundsCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllRefunds(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		refunds := v.(models.Refunds)
		refundsView := c.setRefundsByRefundsModel(refunds)

		list = append(list, refundsView)
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get One Refunds
// @router /:sn
func (c *RefundsController) GetOneRefunds() {
	sn := c.Ctx.Input.Param(":sn")

	refunds, err := models.GetRefundsBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	refundsView := c.setRefundsByRefundsModel(*refunds)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, refundsView)
}

// @Title Get All Refunds
// @router / [get]
func (c *RefundsController) GetAllRefunds() {
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
	l, err := models.GetAllRefunds(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		refunds := v.(models.Refunds)
		refundsView := c.setRefundsByRefundsModel(refunds)
		pageList = append(pageList, refundsView)
	}

	cnt, err := models.GetRefundsCount(query)
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

func (c *RefundsController) setRefundsByRefundsModel(refunds models.Refunds) (refundsView model_views.Refunds) {
	refundsView.Id = refunds.Id
	refundsView.IsReview = refunds.IsReview
	refundsView.CreationDate = refunds.CreationDate
	refundsView.Operator = refunds.Operator
	refundsView.Amount = refunds.Amount
	refundsView.PaymentMethod = refunds.PaymentMethod

	refundsView.Method = refunds.Method
	refundsView.MethodName = paymentHelper.GetPaymentMethodName(refunds.Method)
	refundsView.Memo = refunds.Memo

	order, err := models.GetOrderById(refunds.OrderId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	refundsView.OrderId = order.Id
	refundsView.OrderSn = order.Sn

	refundsView.Sn = refunds.Sn
	refundsView.Account = refunds.Account
	refundsView.Bank = refunds.Bank
	refundsView.Payee = refunds.Payee

	return refundsView
}

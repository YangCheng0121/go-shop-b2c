package web

import (
	wechatPayNotify "github.com/silenceper/wechat/v2/pay/notify"
	wechatPayOrder "github.com/silenceper/wechat/v2/pay/order"
	"go-shop-b2c/common/http"
	orderHelper "go-shop-b2c/common/order"
	paymentHelper "go-shop-b2c/common/payment"
	snHelper "go-shop-b2c/common/sn"
	"go-shop-b2c/common/weixin"
	"go-shop-b2c/helpers"
	"go-shop-b2c/models"
	"go-shop-b2c/setting"
	"strconv"
)

type PaymentController struct {
	BaseController
}

// URLMapping ...
func (c *PaymentController) URLMapping() {
	c.Mapping("Payment", c.Payment)
}

// Config 是传出用于 js sdk 用的参数
type Config struct {
	AppId     string `json:"appId"`
	Timestamp string `json:"timestamp"`
	NonceStr  string `json:"nonceStr"`
	PrePayID  string `json:"prePayId"`
	SignType  string `json:"signType"`
	Package   string `json:"package"`
	PaySign   string `json:"paySign"`
}

// @Title 支付
// @router /payment [post]
func (c *PaymentController) Payment() {
	var sn string
	var tradeType string
	// sn
	if v := c.GetString("sn"); v != "" {
		sn = v
	}
	// tradeType
	if v := c.GetString("tradeType"); v != "" {
		tradeType = v
	}

	order, err := models.GetOrderBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	member, err := models.GetMemberById(c.Member.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	pay := weixin.GetPay()
	orderCtl := pay.GetOrder()

	/**
	 * 微信统一下单
	 */
	params := &wechatPayOrder.Params{}
	/**
	 * 获取支付 总金额
	 * 单位为分
	 */
	params.TotalFee = weixin.GetTotalFree(order.Amount)

	params.CreateIP = c.Ctx.Input.IP()
	siteName, _ := setting.GetValueByKey("siteName")
	params.Body = siteName
	params.OutTradeNo = order.Sn
	params.OpenID = member.OpenId
	params.TradeType = tradeType

	prePayOrder, err := orderCtl.PrePayOrder(params)
	if err != nil {
		c.ServerError(err)
		return
	}

	config, err := orderCtl.BridgeConfig(params)
	if err != nil {
		c.ServerError(err)
		return
	}

	var configView Config
	configView.AppId = prePayOrder.AppID
	configView.Timestamp = config.Timestamp
	configView.NonceStr = config.NonceStr
	configView.PrePayID = config.PrePayID
	configView.SignType = config.SignType
	configView.Package = config.Package
	configView.PaySign = config.PaySign

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, configView)
}

// @Title 增加支付记录
func (c *PaymentController) AddPayment(paidResult wechatPayNotify.PaidResult) error {
	order, err := models.GetOrderBySn(*paidResult.OutTradeNo)
	if err != nil {
		return err
	}

	/**
	 * 更新订单
	 */
	order.AmountPaid = float64(int64(*paidResult.TotalFee)) / 100
	order.Status = orderHelper.GetOrderStatusByAlias("pendingReview")

	err = models.UpdateOrderById(order)
	if err != nil {
		return err
	}

	/**
	 * 商户系统对于支付结果通知的内容一定要做签名验证,并校验返回的订单金额是否与商户侧的订单金额一致，防止数据泄漏导致出现“假通知”，造成资金损失。
	 */
	amount := int(int64(order.Amount * 100))
	if amount != *paidResult.TotalFee {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "订单金额和微信支付金额不一致!")
		return err
	}

	payment := &models.Payment{}
	payment.MemberId = order.MemberId
	payment.OrderId = int64(order.Id)
	payment.CreateBy = order.CreateBy
	payment.Amount = order.AmountPaid

	/**
	 * 支付 SN
	 */
	paymentSn := snHelper.GetSnTypeByAlias("payment")
	node, _ := helpers.NewWorker(int64(paymentSn))
	payment.Sn = strconv.FormatInt(node.GetId(), 10)

	payment.Fee = order.Fee
	payment.Method = order.PaymentMethodType
	payment.Payer = order.CreateBy

	weiXinPaymentPlugin := models.GetWeiXinPaymentPlugin()

	payment.PaymentPluginId = weiXinPaymentPlugin.PluginId
	payment.PaymentMethod = weiXinPaymentPlugin.PaymentName

	_, err = models.AddPayment(payment)
	if err != nil {
		return err
	}

	var paymentLog models.PaymentLog
	paymentLog.PaymentPluginId = weiXinPaymentPlugin.PluginId
	paymentLog.CreateBy = order.CreateBy
	paymentLog.Fee = payment.Fee
	paymentLog.Sn = payment.Sn
	paymentLog.OrderId = &models.Order{Id: order.Id}
	paymentLog.Amount = payment.Amount
	paymentLog.MemberId = &models.Member{Id: int(order.MemberId)}
	paymentLog.Status = paymentHelper.GetPaymentStatusByAlias("success")
	paymentLog.Memo = payment.Memo

	_, err = models.AddPaymentLog(&paymentLog)
	if err != nil {
		return err
	}
	return nil
}

package web

import (
	"bee-shop-b2c/common/weixin"
	"encoding/xml"
	"io/ioutil"

	"github.com/astaxie/beego/logs"
	wechatPayNotify "github.com/silenceper/wechat/v2/pay/notify"
)

type NotifyController struct {
	JsonController
}

// URLMapping ...
func (c *NotifyController) URLMapping() {
	c.Mapping("NotifyPayment", c.NotifyPayment)
}

// @Title 微信支付结果通知
// @router /payment
func (c *NotifyController) NotifyPayment() {
	body, err := ioutil.ReadAll(c.Ctx.Input.Context.Request.Body)
	if err != nil {
		logs.Info("读取http body失败, 原因!", err)
		return
	}

	logs.Info("微信支付异步通知，HTTP Body:", string(body))

	var paidResult wechatPayNotify.PaidResult
	err = xml.Unmarshal(body, &paidResult)
	if err != nil {
		logs.Info("解析HTTP Body格式到xml失败, 原因!", err)
	}

	notify := weixin.GetPayNotify()
	check := notify.PaidVerifySign(paidResult)

	/**
	 * 验证通过
	 * 服务器添加支付、支付记录
	 */
	if check {
		paymentController := &PaymentController{}
		err := paymentController.AddPayment(paidResult)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.Data["xml"] = &paidResult
	c.ServeXML()
}

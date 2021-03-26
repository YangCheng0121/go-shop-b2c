package web

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/models"
	"fmt"
	"math/rand"
	"time"
)

type SmsController struct {
	JsonController
}

// URLMapping ...
func (c *SmsController) URLMapping() {
	c.Mapping("GetSms", c.GetSms)
}

func CreateCaptcha() string {
	return fmt.Sprintf("%04v", rand.New(rand.NewSource(time.Now().UnixNano())).Int31n(10000))
}

// @Title 获取短信验证
// @router / [post]
func (c *SmsController) GetSms() {
	var mobile string

	// mobile
	if v := c.GetString("mobile"); v != "" {
		mobile = v
	}

	if mobile == "" {
		c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrError, http.Fail, "手机号码不能为空")
		return
	}

	rand.Seed(time.Now().Unix())

	sms := &models.Sms{}
	sms.Mobile = mobile

	sms.Code = CreateCaptcha()

	_, err := models.AddSms(sms)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, sms.Code)
}

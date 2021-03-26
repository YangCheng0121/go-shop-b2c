package web

import (
	"go-shop-b2c/common"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/models"
	"time"
)

type UserController struct {
	JsonController
}

// URLMapping ...
func (c *UserController) URLMapping() {
	c.Mapping("Login", c.Login)
	c.Mapping("Logout", c.Logout)
}

// @Title 登录
// @router /login [post]
func (c *UserController) Login() {
	var mobile string
	var sms string

	// mobile
	if v := c.GetString("mobile"); v != "" {
		mobile = v
	}
	// sms
	if v := c.GetString("sms"); v != "" {
		sms = v
	}

	smsModel, err := models.GetSmsByCodeAndMobile(sms, mobile)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "手机和验证码不匹配")
		return
	}
	if smsModel.ExpireDate != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "验证码已过期")
		return
	}
	if smsModel.IsUsed == 1 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "验证码已使用")
		return
	}

	member, _ := models.GetMemberByUsername(mobile)

	if member == nil {
		member = &models.Member{}
	}

	if member.Id > 0 {
		// 最后登录IP
		member.LoginIp = c.Ctx.Input.IP()
		member.LoginDate = time.Now()

		err = models.UpdateMemberById(member)
		if err != nil {
			c.ServerError(err)
			return
		}
	} else {
		member.Username = mobile
		member.Mobile = mobile
		member.MemberRankId = 1 // 普通会员

		_, err := models.AddMember(member)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	/**
	 * 更新短信使用
	 */
	now := time.Now()
	smsModel.UsedDate = &now
	smsModel.IsUsed = 1

	err = models.UpdateSmsById(smsModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 设置Cookie
	 */
	c.SetSessionUser(*member)
	var cookieMember CookieMember
	cookieMember.MemberId = member.Id
	cookieMember.Username = member.Username
	cookieMember.Time = time.Now()
	v, err := helpers.Encode(cookieMember)
	if err == nil {
		c.SetSecureCookie(common.AppKey(), "web_login", v, 24*3600)
	}
	commonController := &CommonController{}
	memberView := commonController.setMemberByMemberModel(*member)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberView)
}

// @Title 注销登录
// @router /logout [post]
func (c *UserController) Logout() {
	if member, ok := c.GetSession(common.SessionName).(models.Member); ok && member.Id > 0 {
		c.SetSessionUser(models.Member{})
		c.SetSecureCookie(common.AppKey(), "web_login", "", -3600)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

package web

import (
	"bee-shop-b2c/common"
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/models"
	"time"
)

type BaseController struct {
	JsonController
	Member *models.Member // 会员
}

type CookieMember struct {
	MemberId int
	Username string
	Time     time.Time
}

/**
 * 每个子类Controller公用方法调用前，都执行一下Prepare方法
 */
func (c *BaseController) Prepare() {
	c.Member = &models.Member{} // 初始化
	/**
	 * 从session中获取用户信息
	 */
	if member, ok := c.GetSession(common.SessionName).(models.Member); ok && member.Id > 0 {
		c.Member = &member
	} else {
		/**
		 * 如果Cookie中存在登录信息，从cookie中获取用户信息
		 */
		if cookie, ok := c.GetSecureCookie(common.AppKey(), "web_login"); ok {
			var cookieMember CookieMember
			err := helpers.Decode(cookie, &cookieMember)
			if err == nil {
				member, err := models.GetMemberById(cookieMember.MemberId)
				if err == nil {
					c.SetSessionUser(*member)
					c.Member = member
				}
			}
		} else {
			/**
			 * Cookie 失效或者过期
			 */
			c.SetSessionUser(models.Member{})
			c.SetSecureCookie(common.AppKey(), "web_login", "", -3600)
			c.JsonResult(http.GetHttpStatusByAlias("ok"), http.UNAUTHORIZED, http.Fail, "cookie失效或者过期")
		}
	}
}

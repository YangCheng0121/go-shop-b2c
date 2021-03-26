package admin

import (
	"bee-shop-b2c/common"
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/models"
	"time"
)

type BaseController struct {
	JsonController
	Admin *models.Admin // 管理员
}

type CookieAdmin struct {
	AdminId  int
	Username string
	Time     time.Time
}

/**
 * 每个子类Controller公用方法调用前，都执行一下Prepare方法
 */
func (c *BaseController) Prepare() {
	c.Admin = &models.Admin{} // 初始化
	/**
	 * 从session中获取用户信息
	 */
	if admin, ok := c.GetSession(common.SessionName).(models.Admin); ok && admin.Id > 0 {
		c.Admin = &admin
	} else {
		/**
		 * 如果Cookie中存在登录信息，从cookie中获取用户信息
		 */
		if cookie, ok := c.GetSecureCookie(common.AppKey(), "login"); ok {
			var cookieAdmin CookieAdmin
			err := helpers.Decode(cookie, &cookieAdmin)
			if err == nil {
				admin, err := models.GetAdminById(int64(cookieAdmin.AdminId))
				if err == nil {
					c.SetSessionUser(*admin)
					c.Admin = admin
				}
			}
		} else {
			/**
			 * Cookie 失效或者过期
			 */
			c.SetSessionUser(models.Admin{})
			c.SetSecureCookie(common.AppKey(), "login", "", -3600)
			c.JsonResult(http.GetHttpStatusByAlias("ok"), http.UNAUTHORIZED, http.Fail, "cookie失效或者过期")
		}
	}
}

/**
 * 设置会员登录信息
 */
func (c *BaseController) SetSessionUser(admin models.Admin) {
	if admin.Id <= 0 {
		c.DelSession(common.SessionName)
		c.DelSession("uid")
		c.DestroySession()
	} else {
		c.SetSession(common.SessionName, admin)
		c.SetSession("uid", admin.Id)
	}
}

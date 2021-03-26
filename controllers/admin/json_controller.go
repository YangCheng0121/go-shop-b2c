package admin

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
	"go-shop-b2c/common"
	"go-shop-b2c/common/http"
	"go-shop-b2c/models"
)

type JsonController struct {
	beego.Controller
}

/**
 * Ajax接口返回Json
 */
func (c *JsonController) JsonResult(status int, errCode int, errMsg string, data ...interface{}) {
	jsonData := make(map[string]interface{}, 3)
	jsonData["err_code"] = errCode
	jsonData["message"] = errMsg

	if len(data) > 0 && data[0] != nil {
		jsonData["data"] = data[0]
	}
	c.Ctx.Output.SetStatus(status)
	c.Data["json"] = jsonData
	c.ServeJSON()
}

/**
 * 服务器报错
 */
func (c *JsonController) ServerError(err error) {
	c.Ctx.Output.SetStatus(http.GetHttpStatusByAlias("internalServerError"))
	logs.Error(err)
}

/**
 * 设置登录管理员信息
 */
func (c *JsonController) SetSessionUser(admin models.Admin) {
	if admin.Id <= 0 {
		c.DelSession(common.SessionName)
		c.DelSession("uid")
		c.DestroySession()
	} else {
		c.SetSession(common.SessionName, admin)
		c.SetSession("uid", admin.Id)
	}
}

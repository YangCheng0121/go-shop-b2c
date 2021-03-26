package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	"go-shop-b2c/setting"
)

type SettingController struct {
	BaseController
}

// URLMapping ...
func (c *SettingController) URLMapping() {
	c.Mapping("GetAllSetting", c.GetAllSetting)
	c.Mapping("UpdateSetting", c.UpdateSetting)
}

// 更新系统设置
// @router /update [put]
func (c *SettingController) UpdateSetting() {
	var s setting.SConfig

	// setting
	if v := c.GetString("body"); v != "" {
		if err := json.Unmarshal([]byte(v), &s); err != nil {
			c.ServerError(err)
			return
		}
	}

	err := setting.UpdateSetting(s)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// 获取系统设置
// @router / [get]
func (c *SettingController) GetAllSetting() {
	s, err := setting.GetAllSetting()
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, s)
}

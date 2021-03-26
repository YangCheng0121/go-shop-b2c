package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	pluginHelper "go-shop-b2c/common/plugin"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type PluginConfigController struct {
	BaseController
}

// URLMapping ...
func (c *PluginConfigController) URLMapping() {
	c.Mapping("AddPluginConfig", c.AddPluginConfig)
	c.Mapping("DeletePluginConfig", c.DeletePluginConfig)
	c.Mapping("UpdatePluginConfig", c.UpdatePluginConfig)
	c.Mapping("GePluginConfigCount", c.GePluginConfigCount)
	c.Mapping("GetPluginConfig", c.GetPluginConfig)
	c.Mapping("GetAllPluginConfig", c.GetAllPluginConfig)
}

// @Title Add PluginConfig
// @router /add [post]
func (c *PluginConfigController) AddPluginConfig() {
	var pluginConfig model_views.PluginConfig

	if v := c.GetString("plugin_config"); v != "" {
		_ = json.Unmarshal([]byte(v), &pluginConfig)
	}

	var pluginConfigModel models.PluginConfig
	pluginConfigModel.Id = pluginConfig.Id
	pluginConfigModel.Attributes = pluginConfig.Attributes
	pluginConfigModel.IsEnabled = pluginConfig.IsEnabled
	pluginConfigModel.Orders = pluginConfig.Orders

	_, err := models.AddPluginConfig(&pluginConfigModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete PluginConfig
// @router /delete [delete]
func (c *PluginConfigController) DeletePluginConfig() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		pluginConfig, err := models.GetPluginConfigById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		pluginConfig.LastUpdatedBy = c.Admin.Name
		pluginConfig.DeleteFlag = 1

		err = models.UpdatePluginConfigById(pluginConfig)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update PluginConfig
// @router /update [put]
func (c *PluginConfigController) UpdatePluginConfig() {
	var pluginConfig model_views.PluginConfig

	if v := c.GetString("plugin_config"); v != "" {
		_ = json.Unmarshal([]byte(v), &pluginConfig)
	}

	pluginConfigModel, err := models.GetPluginConfigById(pluginConfig.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	pluginConfigModel.Id = pluginConfig.Id
	pluginConfigModel.Attributes = pluginConfig.Attributes
	pluginConfigModel.IsEnabled = pluginConfig.IsEnabled
	pluginConfigModel.Orders = pluginConfig.Orders

	err = models.UpdatePluginConfigById(pluginConfigModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// Get PluginConfig Count
// @router /count [get]
func (c *PluginConfigController) GePluginConfigCount() {
	var query = make(map[string]string)
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

	query["DeleteFlag"] = "0"
	cnt, err := models.GetPluginConfigCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get PluginConfig
// @router /:id [get]
func (c *PluginConfigController) GetPluginConfig() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	paymentPlugin, err := models.GetPluginConfigById(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	paymentPluginView := c.setPluginConfigByPluginConfigModel(*paymentPlugin)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, paymentPluginView)
}

// @Title Get All PluginConfig
// @router / [get]
func (c *PluginConfigController) GetAllPluginConfig() {
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

	if query["Type"] != "" {
		query["Type"] = strconv.Itoa(pluginHelper.GetPluginTypeByAlias(query["Type"]))
	}

	cnt, err := models.GetPluginConfigCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllPluginConfig(query, nil, sortby, order, offset, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		pluginConfig := v.(models.PluginConfig)
		pluginConfigView := c.setPluginConfigByPluginConfigModel(pluginConfig)
		pageList = append(pageList, pluginConfigView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *PluginConfigController) setPluginConfigByPluginConfigModel(pluginConfig models.PluginConfig) (pluginConfigView model_views.PluginConfig) {
	pluginConfigView.Id = pluginConfig.Id
	pluginConfigView.Orders = pluginConfig.Orders
	pluginConfigView.IsEnabled = pluginConfig.IsEnabled
	pluginConfigView.Attributes = pluginConfig.Attributes
	pluginConfigView.PluginId = pluginConfig.PluginId
	pluginConfigView.Type = pluginConfig.Type
	pluginConfigView.CreateBy = pluginConfig.CreateBy

	return pluginConfigView
}

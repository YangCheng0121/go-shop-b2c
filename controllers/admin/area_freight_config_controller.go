package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type AreaFreightConfigController struct {
	BaseController
}

// URLMapping ...
func (c *AreaFreightConfigController) URLMapping() {
	c.Mapping("AddAreaFreightConfig", c.AddAreaFreightConfig)
	c.Mapping("DeleteAreaFreightConfig", c.DeleteAreaFreightConfig)
	c.Mapping("UpdateAreaFreightConfig", c.UpdateAreaFreightConfig)
	c.Mapping("GetOneAreaFreightConfig", c.GetAreaFreightConfig)
	c.Mapping("AreaFreightConfigController", c.GetAreaFreightConfigCount)
	c.Mapping("GetAllAreaFreightConfig", c.GetAllAreaFreightConfig)
}

// @Title Add AreaFreightConfig
// @router /add [post]
func (c *AreaFreightConfigController) AddAreaFreightConfig() {
	var areaFreightConfig model_views.AreaFreightConfig

	if v := c.GetString("areaFreightConfig"); v != "" {
		_ = json.Unmarshal([]byte(v), &areaFreightConfig)
	}

	var areaFreightConfigModel models.AreaFreightConfig
	areaFreightConfigModel.AreaId = &models.Area{Id: areaFreightConfig.AreaId}

	if _, err := models.GetAreaFreightConfigByAreaId(areaFreightConfig.AreaId); err == nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "不能添加相同的地区")
		return
	}

	areaFreightConfigModel.ShippingMethodId = &models.ShippingMethod{Id: areaFreightConfig.ShippingMethodId}
	areaFreightConfigModel.FirstPrice = areaFreightConfig.FirstPrice
	areaFreightConfigModel.ContinuePrice = areaFreightConfig.ContinuePrice
	areaFreightConfigModel.CreateBy = c.Admin.Name

	_, err := models.AddAreaFreightConfig(&areaFreightConfigModel)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete AreaFreightConfig
// @router /delete [delete]
func (c *AreaFreightConfigController) DeleteAreaFreightConfig() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		areaFreightConfig, err := models.GetAreaFreightConfigById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		areaFreightConfig.LastUpdatedBy = c.Admin.Name
		areaFreightConfig.DeleteFlag = 1

		err = models.UpdateAreaFreightConfigById(areaFreightConfig)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update AreaFreightConfig
// @router /update [put]
func (c *AreaFreightConfigController) UpdateAreaFreightConfig() {
	var areaFreightConfig model_views.AreaFreightConfig

	if v := c.GetString("areaFreightConfig"); v != "" {
		_ = json.Unmarshal([]byte(v), &areaFreightConfig)
	}

	areaFreightConfigModel, err := models.GetAreaFreightConfigById(areaFreightConfig.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	areaFreightConfigModel.AreaId = &models.Area{Id: areaFreightConfig.AreaId}
	areaFreightConfigModel.ShippingMethodId = &models.ShippingMethod{Id: areaFreightConfig.ShippingMethodId}
	areaFreightConfigModel.FirstPrice = areaFreightConfig.FirstPrice
	areaFreightConfigModel.ContinuePrice = areaFreightConfig.ContinuePrice
	areaFreightConfigModel.CreateBy = c.Admin.Name

	err = models.UpdateAreaFreightConfigById(areaFreightConfigModel)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get One AreaFreightConfig
// @router /:id
func (c *AreaFreightConfigController) GetAreaFreightConfig() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	areaFreightConfig, err := models.GetAreaFreightConfigById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	areaFreightConfigView := c.setAreaFreightConfigByAreaFreightConfigModel(*areaFreightConfig)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, areaFreightConfigView)
}

// Get AreaFreightConfig Count
// @router /count
func (c *AreaFreightConfigController) GetAreaFreightConfigCount() {
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
	cnt, err := models.GetAreaFreightConfigCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get All Area FreightConfig
// @router / [get]
func (c *AreaFreightConfigController) GetAllAreaFreightConfig() {
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
	l, err := models.GetAllAreaFreightConfig(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		areaFreightConfig := v.(models.AreaFreightConfig)
		areaFreightConfigView := c.setAreaFreightConfigByAreaFreightConfigModel(areaFreightConfig)
		pageList = append(pageList, areaFreightConfigView)
	}

	cnt, err := models.GetAreaFreightConfigCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, *pages)
}

func (c *AreaFreightConfigController) setAreaFreightConfigByAreaFreightConfigModel(areaFreightConfig models.AreaFreightConfig) (areaFreightConfigView model_views.AreaFreightConfig) {
	areaFreightConfigView.Id = areaFreightConfig.Id
	areaFreightConfigView.ContinuePrice = areaFreightConfig.ContinuePrice
	areaFreightConfigView.FirstPrice = areaFreightConfig.FirstPrice
	areaFreightConfigView.AreaId = areaFreightConfig.AreaId.Id

	area, err := models.GetAreaById(areaFreightConfig.AreaId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	areaFreightConfigView.AreaName = area.Name
	areaFreightConfigView.AreaFullName = area.FullName

	areaFreightConfigView.ShippingMethodId = areaFreightConfig.ShippingMethodId.Id
	shippingMethod, err := models.GetShippingMethodById(areaFreightConfig.ShippingMethodId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	areaFreightConfigView.ShippingMethodName = shippingMethod.Name
	return areaFreightConfigView
}

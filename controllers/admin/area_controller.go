package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type AreaController struct {
	BaseController
}

// URLMapping ...
func (c *AreaController) URLMapping() {
	c.Mapping("AddArea", c.AddArea)
	c.Mapping("DeleteArea", c.DeleteArea)
	c.Mapping("UpdateArea", c.UpdateArea)
	c.Mapping("GetArea", c.GetArea)
	c.Mapping("GetAreaCount", c.GetAreaCount)
	c.Mapping("GetAllArea", c.GetAllArea)
}

// @Title Add Area
// @router /add [post]
func (c *AreaController) AddArea() {
	var area model_views.Area
	var areaModel models.Area

	if v := c.GetString("area"); v != "" {
		_ = json.Unmarshal([]byte(v), &area)
	}

	areaModel.Name = area.Name
	areaModel.Orders = area.Orders
	areaModel.ParentId = area.ParentId
	areaModel.CreateBy = c.Admin.Name

	_, err := models.AddArea(&areaModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	var parentId = areaModel.ParentId
	var treePath = ","
	if parentAreaModel, _ := models.GetAreaById(int(parentId)); parentAreaModel != nil {
		parentIdStr := strconv.Itoa(int(parentId))
		areaModel.TreePath = parentAreaModel.TreePath + parentIdStr + treePath
		areaModel.FullName = parentAreaModel.FullName + areaModel.Name
	} else {
		areaModel.FullName = areaModel.Name
		areaModel.TreePath = treePath
	}

	err = models.UpdateAreaById(&areaModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title DeleteArea
// @router /delete [delete]
func (c *AreaController) DeleteArea() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		area, err := models.GetAreaById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		/**
		 * 删除下级分类
		 */
		var query = make(map[string]string)
		query["Name__icontains"] = area.Name
		query["DeleteFlag"] = "0"
		cnt, err := models.GetAreaCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		l, err := models.GetAllArea(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}
		for _, v := range l {
			childArea := v.(models.Area)

			childArea.LastUpdatedBy = c.Admin.Name
			childArea.DeleteFlag = 1
			err = models.UpdateAreaById(&childArea)
			if err != nil {
				c.ServerError(err)
				return
			}
		}

		area.LastUpdatedBy = c.Admin.Name
		area.DeleteFlag = 1
		err = models.UpdateAreaById(area)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Area
// @router /update [put]
func (c *AreaController) UpdateArea() {
	var area model_views.Area

	if v := c.GetString("area"); v != "" {
		_ = json.Unmarshal([]byte(v), &area)
	}

	areaModel, err := models.GetAreaById(area.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	areaModel.Name = area.Name

	var fullName string
	if areaModel.ParentId > 0 {
		for {
			parentAreaModel, err := models.GetAreaById(int(areaModel.ParentId))
			if err != nil {
				c.ServerError(err)
				return
			}
			fullName = fullName + parentAreaModel.Name

			if parentAreaModel.ParentId <= 0 {
				break
			}
		}
	}

	areaModel.FullName = fullName
	areaModel.Orders = area.Orders
	areaModel.LastUpdatedBy = c.Admin.Name

	err = models.UpdateAreaById(areaModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Area
// @router /:id
func (c *AreaController) GetArea() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	area, err := models.GetAreaById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, true)
		return
	}
	areaView := c.setAreaByAreaModel(*area)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, areaView)
}

// @Title Get Area Count
// @router /count
func (c *AreaController) GetAreaCount() {
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
	cnt, err := models.GetAreaCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get All Area
// @router / [get]
func (c *AreaController) GetAllArea() {
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
	cnt, err := models.GetAreaCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllArea(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, area := range l {
		area := area.(models.Area)
		areaView := c.setAreaByAreaModel(area)

		list = append(list, areaView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

/**
 * AreaModel 转为 AreaView
 */
func (c *AreaController) setAreaByAreaModel(area models.Area) (areaView model_views.Area) {
	areaView.Id = area.Id
	areaView.Name = area.Name
	areaView.FullName = area.FullName
	areaView.ParentId = area.ParentId
	areaView.Orders = area.Orders
	areaView.TreePath = area.TreePath

	return areaView
}

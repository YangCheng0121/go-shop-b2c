package web

import (
	"go-shop-b2c/common/http"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strings"
)

type AreaController struct {
	BaseController
}

// URLMapping ...
func (c *AreaController) URLMapping() {
	c.Mapping("GetAllArea", c.GetAllArea)
}

// @Title 获取所有区域
// @router /
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

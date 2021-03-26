package admin

import (
	"go-shop-b2c/common/http"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strings"
)

type PermissionController struct {
	BaseController
}

// URLMapping ...
func (c *PermissionController) URLMapping() {
	c.Mapping("GetAllPermission", c.GetAllPermission)
}

// GetAllPermission ...
// @Title Get All Permission List
// @Description Get All Admin List
// @Param	query	    query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields	    query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	order	    query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ...
// @Param	sortby	    query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	pageNumber	query	string	false	"Start position of result set. Must be an integer"
// @Param	pageSize	query	int	    false	"Limit the size of result set. Must be an integer"
// @router  / [get]
// @Success 200 {object} models.Admin
// @Failure 500
func (c *PermissionController) GetAllPermission() {
	var sortby []string
	var order []string
	var query = make(map[string]string)

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

	cnt, err := models.GetPermissionCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	query["DeleteFlag"] = "0"
	l, err := models.GetAllPermission(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		permission := v.(models.Permission)
		permissionView := c.setPermissionByPermissionModel(permission)
		list = append(list, permissionView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

func (c *PermissionController) setPermissionByPermissionModel(permission models.Permission) (permissionView model_views.Permission) {
	permissionView.Id = permission.Id
	permissionView.Name = permission.Name
	permissionView.Description = permission.Description
	permissionView.Value = permission.Value
	permissionView.Module = permission.Module

	return permissionView
}

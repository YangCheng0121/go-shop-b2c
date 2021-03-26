package admin

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"encoding/json"
	"github.com/astaxie/beego/utils"
	"strconv"
	"strings"
)

type RoleController struct {
	BaseController
}

// URLMapping ...
func (c *RoleController) URLMapping() {
	c.Mapping("AddRole", c.AddRole)
	c.Mapping("DeleteRole", c.DeleteRole)
	c.Mapping("UpdateRole", c.UpdateRole)
	c.Mapping("GetRole", c.GetRole)
	c.Mapping("GetRoleCount", c.GetRoleCount)
	c.Mapping("GetAllRole", c.GetAllRole)
}

// @Title Add Role
// @router /add [post]
func (c *RoleController) AddRole() {
	var role model_views.Role

	if v := c.GetString("role"); v != "" {
		_ = json.Unmarshal([]byte(v), &role)
	}

	var roleModel models.Role
	roleModel.IsSystem = role.IsSystem
	roleModel.Value = role.Value
	roleModel.Description = role.Description
	roleModel.Name = role.Name
	roleModel.CreateBy = c.Admin.Name

	id, err := models.AddRole(&roleModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, permission := range role.Permissions {
		err := models.AddPermissionRole(permission.Id, int(id))
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Role
// @router /delete [delete]
func (c *RoleController) DeleteRole() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		role, err := models.GetRoleById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		role.LastUpdatedBy = c.Admin.Name
		role.DeleteFlag = 1

		err = models.UpdateRoleById(role)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Role
// @router /update [put]
func (c *RoleController) UpdateRole() {
	var role model_views.Role

	if v := c.GetString("role"); v != "" {
		_ = json.Unmarshal([]byte(v), &role)
	}

	roleModel, err := models.GetRoleById(role.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	roleModel.IsSystem = role.IsSystem
	roleModel.Value = role.Value
	roleModel.Description = role.Description
	roleModel.Name = role.Name
	roleModel.Value = role.Value
	roleModel.LastUpdatedBy = c.Admin.Name

	var permissionIdsStr []string
	var nextPermissionIdsStr []string

	permissions, err := models.GetPermissionRoleByRole(role.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range permissions {
		idStr := strconv.Itoa(v.Permissions)
		permissionIdsStr = append(permissionIdsStr, idStr)
	}

	for _, v := range role.Permissions {
		idStr := strconv.Itoa(v.Id)
		nextPermissionIdsStr = append(nextPermissionIdsStr, idStr)
	}

	/**
	 * 新增权限角色关联
	 */
	for _, idStr := range nextPermissionIdsStr {
		if in := utils.InSlice(idStr, permissionIdsStr); in == false {
			id, _ := strconv.Atoi(idStr)
			err = models.AddPermissionRole(id, role.Id)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除权限角色关联
	 */
	for _, idStr := range permissionIdsStr {
		if in := utils.InSlice(idStr, nextPermissionIdsStr); in == false {
			id, _ := strconv.Atoi(idStr)
			err = models.DeletePermissionRole(id, role.Id)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	err = models.UpdateRoleById(roleModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Role
// @router /:id [get]
func (c *RoleController) GetRole() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	role, err := models.GetRoleById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	roleView := c.setRoleByRoleModel(*role)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, roleView)
}

// @Title Get Role Count
// @router /count
func (c *RoleController) GetRoleCount() {
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
	cnt, err := models.GetRoleCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// GetAllRole ...
// @Title Get All Role List
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
func (c *RoleController) GetAllRole() {
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
	l, err := models.GetAllRole(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		role := v.(models.Role)
		roleView := c.setRoleByRoleModel(role)
		pageList = append(pageList, roleView)
	}

	cnt, err := models.GetRoleCount(query)
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

func (c *RoleController) setRoleByRoleModel(role models.Role) (roleView model_views.Role) {
	roleView.Id = role.Id
	roleView.Name = role.Name
	roleView.Description = role.Description
	roleView.Value = role.Value
	roleView.Orders = role.Orders
	roleView.IsSystem = role.IsSystem
	roleView.CreationDate = role.CreationDate

	/**
	 * 是否系统角色 0 否、1 是
	 */
	if role.IsSystem == 0 {
		permissionRoles, err := models.GetPermissionRoleByRole(role.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		for _, v := range permissionRoles {
			permission, err := models.GetPermissionById(v.Permissions)
			if err != nil {
				c.ServerError(err)
				return
			}
			permissionView := c.setPermissionByPermissionModel(*permission)
			roleView.Permissions = append(roleView.Permissions, permissionView)
		}
	}

	if role.IsSystem == 1 {
		var query = make(map[string]string)
		query["DeleteFlag"] = "0"

		cnt, err := models.GetPermissionCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		l, err := models.GetAllPermission(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}

		for _, v := range l {
			permission := v.(models.Permission)
			permissionView := c.setPermissionByPermissionModel(permission)
			roleView.Permissions = append(roleView.Permissions, permissionView)
		}
	}

	return roleView
}

func (c *RoleController) setPermissionByPermissionModel(permission models.Permission) (permissionView model_views.Permission) {
	permissionView.Id = permission.Id
	permissionView.Name = permission.Name
	permissionView.Description = permission.Description
	permissionView.Value = permission.Value
	permissionView.Module = permission.Module

	return permissionView
}

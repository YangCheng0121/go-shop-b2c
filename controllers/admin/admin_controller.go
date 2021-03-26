package admin

import (
	"bee-shop-b2c/common"
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"github.com/astaxie/beego/utils"
	"regexp"
	"strconv"
	"strings"
)

type AdminController struct {
	BaseController
}

// URLMapping ...
func (c *AdminController) URLMapping() {
	c.Mapping("AddAdmin", c.AddAdmin)
	c.Mapping("DeleteAdmin", c.DeleteAdmin)
	c.Mapping("UpdateAdmin", c.UpdateAdmin)
	c.Mapping("GetAdmin", c.GetAdmin)
	c.Mapping("GetAllAdmin", c.GetAllAdmin)
}

// @Title Add Admin
// @router /add [post]
func (c *AdminController) AddAdmin() {
	var username string
	var password1 string
	var password2 string
	var email string
	var department string
	var nickname string
	var isEnabled int

	// username
	if v := c.GetString("username"); v != "" {
		username = v
	}
	// password1
	if v := c.GetString("password1"); v != "" {
		password1 = v
	}
	// password2
	if v := c.GetString("password2"); v != "" {
		password2 = v
	}
	// email
	if v := c.GetString("email"); v != "" {
		email = v
	}
	// isEnabled
	if v := c.GetString("is_enabled"); v != "" {
		isEnabled, _ = strconv.Atoi(v)
	}
	// department
	if v := c.GetString("department"); v != "" {
		department = v
	}
	// nickname
	if v := c.GetString("nickname"); v != "" {
		nickname = v
	}

	if password1 != password2 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "两次密码不一致")
		return
	}

	if l := strings.Count(password1, ""); password1 == "" || l > 20 || l < 6 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "密码必须在6-20个字符之间")
		return
	}

	if ok, err := regexp.MatchString(common.RegexpEmail, email); !ok || err != nil || email == "" {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "邮箱格式错误")
		return
	}

	var adminModel models.Admin
	adminModel.Username = username
	adminModel.Name = nickname
	adminModel.IsEnabled = int8(isEnabled)
	adminModel.Department = department
	adminModel.CreateBy = c.Admin.Name
	adminModel.Email = email
	adminModel.Hasher = "default_hasher"

	hashPassword, err := helpers.PasswordHash(password1)
	if err != nil {
		c.ServerError(err)
		return
	}
	adminModel.Password = hashPassword

	_, err = models.AddAdmin(&adminModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Admin
// @router /delete [delete]
func (c *AdminController) DeleteAdmin() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		admin, err := models.GetAdminById(int64(id))
		if err != nil {
			c.ServerError(err)
			return
		}
		admin.LastUpdatedBy = c.Admin.Name
		admin.DeleteFlag = 1

		err = models.UpdateAdminById(admin)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// UpdateAdmin ...
// @Title Update Admin
// @Description update Admin by some info
// @Param id         path string  true	"The id you want to update"
// @Param password1  body string  true  "Should update Admin password1"
// @Param password2  body string  true  "Should update Admin password2"
// @Param email      body string  true  "Admin email"
// @Param role_name  body string  true  "Admin role name"
// @Param is_enabled body int     true  "If enabled"
// @Param department body string  false "Admin Department"
// @Param nickname   boyd string  false "Admin Nickname"
// @Success 200 nil
// @Failure 500
// @router /update [put]
func (c *AdminController) UpdateAdmin() {
	var id int
	var password1 string
	var password2 string
	var email string
	var department string
	var nickname string
	var isEnabled int
	var roles []string

	// id
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}
	// password1
	if v := c.GetString("password1"); v != "" {
		password1 = v
	}
	// password2
	if v := c.GetString("password2"); v != "" {
		password2 = v
	}
	// email
	if v := c.GetString("email"); v != "" {
		email = v
	}
	// isEnabled
	if v := c.GetString("is_enabled"); v != "" {
		isEnabled, _ = strconv.Atoi(v)
	}
	// department
	if v := c.GetString("department"); v != "" {
		department = v
	}
	// roles
	if v := c.GetString("roles"); v != "" {
		roles = strings.Split(v, ",")
	}
	// nickname
	if v := c.GetString("nickname"); v != "" {
		nickname = v
	}

	if password1 != password2 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, "两次密码不一致")
		return
	}

	if l := strings.Count(password1, ""); password1 == "" || l > 20 || l < 6 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, "密码必须在6-20个字符之间")
		return
	}

	if ok, err := regexp.MatchString(common.RegexpEmail, email); !ok || err != nil || email == "" {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, "邮箱格式错误")
		return
	}

	hashPassword, err := helpers.PasswordHash(password1)
	if err != nil {
		c.ServerError(err)
		return
	}

	currentAdmin, err := models.GetAdminById(int64(id))
	if err != nil {
		c.ServerError(err)
		return
	}

	var roleIdsStr []string
	var nextRoleIdsStr []string

	rolesModel, err := models.GetAdminRoleIdByAdmins(currentAdmin.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range rolesModel {
		idStr := strconv.Itoa(int(v.Roles))
		roleIdsStr = append(roleIdsStr, idStr)
	}
	nextRoleIdsStr = roles

	/**
	 * 新增管理员和角色关联
	 */
	for _, idStr := range nextRoleIdsStr {
		if in := utils.InSlice(idStr, roleIdsStr); in == false {
			id, _ := strconv.Atoi(idStr)
			err = models.AddAdminAndRole(currentAdmin.Id, int64(id))
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除管理员和角色关联
	 */
	for _, idStr := range roleIdsStr {
		if in := utils.InSlice(idStr, nextRoleIdsStr); in == false {
			id, _ := strconv.Atoi(idStr)
			err = models.DeleteAdminRole(int(currentAdmin.Id), id)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 赋值并更新 Admin
	 */
	currentAdmin.Department = department
	currentAdmin.Name = nickname
	currentAdmin.Password = hashPassword
	currentAdmin.Email = email
	currentAdmin.IsEnabled = int8(isEnabled)

	err = models.UpdateAdminById(currentAdmin)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Admin
// @router /:id [get]
func (c *AdminController) GetAdmin() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	admin, err := models.GetAdminById(int64(id))
	if err != nil {
		c.ServerError(err)
		return
	}
	adminView := c.setAdminByAdminModel(*admin)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, adminView)
}

// GetAllAdmin ...
// @Title Get All Admin List
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
func (c *AdminController) GetAllAdmin() {
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
	l, err := models.GetAllAdmin(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		admin := v.(models.Admin)
		adminView := c.setAdminByAdminModel(admin)
		pageList = append(pageList, adminView)
	}

	/**
	 * 查询 Admin Count
	 */
	cnt, err := models.GetAdminCount(query)
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

func (c *AdminController) setAdminByAdminModel(admin models.Admin) (adminView model_views.Admin) {
	adminView.Id = strconv.Itoa(int(admin.Id))
	adminView.Name = admin.Name
	adminView.Username = admin.Username
	adminView.Department = admin.Department
	adminView.Email = admin.Email
	adminView.IsEnabled = admin.IsEnabled
	adminView.IsLocked = admin.IsLocked
	adminView.LoginIp = admin.LoginIp
	adminView.CreationDate = admin.CreationDate

	adminRoles, err := models.GetAdminRoleIdByAdmins(admin.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range adminRoles {
		id := v.Roles
		/**
		 * 角色
		 */
		adminView.Roles = int(id)
	}

	return adminView
}

func (c *AdminController) setPermissionByPermissionModel(permission models.Permission) (permissionView model_views.Permission) {
	permissionView.Id = permission.Id
	permissionView.Name = permission.Name
	permissionView.Description = permission.Description
	permissionView.Value = permission.Value
	permissionView.Module = permission.Module

	return permissionView
}

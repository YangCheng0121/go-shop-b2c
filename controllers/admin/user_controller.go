package admin

import (
	"bee-shop-b2c/common"
	"bee-shop-b2c/common/http"
	roleHelper "bee-shop-b2c/common/role"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"regexp"
	"strconv"
	"strings"
	"time"
)

type UserController struct {
	JsonController
}

// URLMapping ...
func (c *UserController) URLMapping() {
	c.Mapping("Login", c.Login)
	c.Mapping("Register", c.Register)
}

// Login ...
// @Title Login
// @Description Admin Login
// @Param username body string true "Login username"
// @Param password body string true "Login password"
// @Success 200 {object} models.Admin
// @Failure 500
// @router /login [post]
func (c *UserController) Login() {
	var username string
	var password string

	if v := c.GetString("username"); v != "" {
		username = v
	}
	if v := c.GetString("password"); v != "" {
		password = v
	}

	currentAdmin, _ := models.GetAdminByUsernameAndIsEnabled(username, 1)
	if currentAdmin == nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "用户不存在")
		return
	}

	ok, _ := helpers.PasswordVerify(currentAdmin.Password, password)
	if ok {
		c.SetSessionUser(*currentAdmin)

		var cookieAdmin CookieAdmin
		cookieAdmin.AdminId = int(currentAdmin.Id)
		cookieAdmin.Username = currentAdmin.Username
		cookieAdmin.Time = time.Now()
		v, err := helpers.Encode(cookieAdmin)
		if err != nil {
			c.ServerError(err)
		}
		c.SetSecureCookie(common.AppKey(), "admin_login", v, 24*3600)
		// 最后登录IP
		currentAdmin.LoginIp = c.Ctx.Input.IP()
		currentAdmin.LoginDate = time.Now()

		err = models.UpdateAdminById(currentAdmin)
		if err != nil {
			c.ServerError(err)
			return
		}

		adminView := c.setAdminByAdminModel(*currentAdmin)
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, adminView)
	} else {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "密码不正确")
	}
}

// Register ...
// @Title Register
// @Description Admin Register
// @Param username  body string  true  "Register username"
// @Param password1 body string  true  "Register password1"
// @Param password2 body string  true  "Register password2"
// @Param nickname  body string  true  "Register nickname"
// @Param email     body string  true  "Register email"
// @Success 200 nil
// @Failure 500
// @router /register [post]
func (c *UserController) Register() {
	var username string
	var password1 string
	var password2 string
	var nickname string
	var email string

	if v := c.GetString("username"); v != "" {
		username = v
	}
	if v := c.GetString("password1"); v != "" {
		password1 = v
	}
	if v := c.GetString("password2"); v != "" {
		password2 = v
	}
	if v := c.GetString("nickname"); v != "" {
		nickname = v
	}
	if v := c.GetString("email"); v != "" {
		email = v
	}

	if password1 != password2 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Fail, "登录密码与确认密码不一致")
		return
	}

	if l := strings.Count(password1, ""); password1 == "" || l > 20 || l < 6 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Fail, "密码必须在6-20个字符之间")
		return
	}

	if ok, err := regexp.MatchString(common.RegexpEmail, email); !ok || err != nil || email == "" {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Fail, "邮箱格式错误")
		return
	}

	if l := strings.Count(nickname, "") - 1; l < 2 || l > 20 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Fail, "用户昵称限制在2-20个字符")
		return
	}

	currentAdmin, _ := models.GetAdminByUsername(username)
	if currentAdmin != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "该用户已注册")
		return
	}
	currentAdmin = &models.Admin{}
	currentAdmin.Username = username
	currentAdmin.Name = nickname
	currentAdmin.Email = email
	currentAdmin.IsEnabled = 1

	hash, err := helpers.PasswordHash(password1)
	if err != nil {
		c.ServerError(err)
		return
	}
	currentAdmin.Password = hash

	id, err := models.AddAdmin(currentAdmin)

	if err != nil {
		c.ServerError(err)
		return
	}

	role := roleHelper.GetRoleByAlias("R_MEMBER")

	err = models.AddAdminAndRole(id, role)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}
func (c *UserController) setAdminByAdminModel(admin models.Admin) (adminView model_views.Admin) {
	adminView.Id = strconv.Itoa(int(admin.Id))
	adminView.Name = admin.Name
	adminView.Username = admin.Username
	adminView.Department = admin.Department
	adminView.Email = admin.Email
	adminView.IsEnabled = admin.IsEnabled
	adminView.IsLocked = admin.IsLocked
	adminView.LoginIp = admin.LoginIp
	adminView.CreationDate = admin.CreationDate

	roles, err := models.GetAdminRoleIdByAdmins(admin.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range roles {
		role := v.Roles
		adminView.Roles = int(role)
	}

	return adminView
}

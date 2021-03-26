package admin

import (
	"encoding/json"
	"go-shop-b2c/common"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"regexp"
	"strconv"
	"strings"
)

type MemberController struct {
	BaseController
}

// URLMapping ...
func (c *MemberController) URLMapping() {
	c.Mapping("AddMember", c.AddMember)
	c.Mapping("DeleteMember", c.DeleteMember)
	c.Mapping("UpdateMember", c.UpdateMember)
	c.Mapping("GetMember", c.GetMember)
	c.Mapping("GetAllMember", c.GetAllMember)
}

// @Title Add Member
// @router /add [post]
func (c *MemberController) AddMember() {
	var member model_views.Member

	if v := c.GetString("member"); v != "" {
		_ = json.Unmarshal([]byte(v), &member)
	}

	var memberModel models.Member
	memberModel.Username = member.Username
	memberModel.Name = member.Name
	memberModel.Mobile = member.Mobile
	memberModel.Phone = member.Phone
	memberModel.Email = member.Email
	memberModel.IsEnabled = member.IsEnabled
	memberModel.Gender = member.Gender
	memberModel.MemberRankId = member.MemberRankId

	if member.Password1 != member.Password2 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "两次密码不一致")
		return
	}

	if l := strings.Count(member.Password1, ""); member.Password2 == "" || l > 20 || l < 6 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "密码必须在6-20个字符之间")
		return
	}

	if ok, err := regexp.MatchString(common.RegexpEmail, member.Email); !ok || err != nil || member.Email == "" {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "邮箱格式错误")
		return
	}

	hashPassword, err := helpers.PasswordHash(member.Password1)
	if err != nil {
		c.ServerError(err)
		return
	}
	memberModel.Password = hashPassword

	_, err = models.AddMember(&memberModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Member
// @router /delete [delete]
func (c *MemberController) DeleteMember() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		member, err := models.GetMemberById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		member.DeleteFlag = 1

		err = models.UpdateMemberById(member)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Member
// @router /update [put]
func (c *MemberController) UpdateMember() {
	var member model_views.Member

	if v := c.GetString("member"); v != "" {
		_ = json.Unmarshal([]byte(v), &member)
	}

	memberModel, err := models.GetMemberById(member.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	memberModel.Id = member.Id
	memberModel.Username = member.Username
	memberModel.Name = member.Name
	memberModel.Mobile = member.Mobile
	memberModel.Phone = member.Phone
	memberModel.Email = member.Email
	memberModel.IsEnabled = member.IsEnabled
	memberModel.Gender = member.Gender
	memberModel.MemberRankId = member.MemberRankId

	if member.Password1 != member.Password2 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "两次密码不一致")
		return
	}

	if l := strings.Count(member.Password1, ""); member.Password2 == "" || l > 20 || l < 6 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "密码必须在6-20个字符之间")
		return
	}

	if ok, err := regexp.MatchString(common.RegexpEmail, member.Email); !ok || err != nil || member.Email == "" {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "邮箱格式错误")
		return
	}

	hashPassword, err := helpers.PasswordHash(member.Password1)
	if err != nil {
		c.ServerError(err)
		return
	}
	memberModel.Password = hashPassword

	err = models.UpdateMemberById(memberModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Area
// @router /:id
func (c *MemberController) GetMember() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	member, err := models.GetMemberById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
		return
	}
	memberView := c.setMemberByMemberModel(*member)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberView)
}

// @Title GetAllMember
// @Description Get all member by some filed
// @router / [get]
func (c *MemberController) GetAllMember() {
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

	l, err := models.GetAllMember(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetMemberCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		member := v.(models.Member)
		memberView := c.setMemberByMemberModel(member)
		pageList = append(pageList, memberView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

/**
 * MemberModel 转为 MemberView
 */
func (c *MemberController) setMemberByMemberModel(member models.Member) (memberView model_views.Member) {
	memberView.Id = member.Id
	memberView.Balance = member.Balance
	memberView.Username = member.Username
	memberView.CreationDate = member.CreationDate
	memberView.Name = member.Name
	memberView.Amount = member.Amount
	memberView.Mobile = member.Mobile
	memberView.AreaId = member.AreaId
	memberView.Address = member.Address
	memberView.Phone = member.Phone
	memberView.ZipCode = member.ZipCode
	memberView.Email = member.Email
	memberView.IsEnabled = member.IsEnabled
	memberView.LoginIp = member.LoginIp
	memberView.IsLocked = member.IsLocked
	memberView.Point = member.Point
	memberView.Avatar = member.Avatar
	memberView.Birth = member.Birth
	memberView.Gender = member.Gender
	memberView.LockedDate = member.LockedDate
	memberView.LoginDate = member.LoginDate
	memberView.LoginFailureCount = member.LoginFailureCount
	memberView.RegisterIp = member.RegisterIp
	memberView.SafeKeyExpire = member.SafeKeyExpire
	memberView.SafeKeyValue = member.SafeKeyValue

	memberRank, err := models.GetMemberRankById(int(member.MemberRankId))
	if err != nil {
		c.ServerError(err)
		return
	}
	memberView.MemberRank = memberRank.Name
	memberView.MemberRankId = int64(memberRank.Id)

	memberView.AttributeValue0 = member.AttributeValue0
	memberView.AttributeValue1 = member.AttributeValue1
	memberView.AttributeValue2 = member.AttributeValue2
	memberView.AttributeValue3 = member.AttributeValue3
	memberView.AttributeValue4 = member.AttributeValue4
	memberView.AttributeValue5 = member.AttributeValue5
	memberView.AttributeValue6 = member.AttributeValue6
	memberView.AttributeValue7 = member.AttributeValue7
	memberView.AttributeValue8 = member.AttributeValue8
	memberView.AttributeValue9 = member.AttributeValue9

	return memberView
}

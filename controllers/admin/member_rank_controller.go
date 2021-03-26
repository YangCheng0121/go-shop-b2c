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

type MemberRankController struct {
	BaseController
}

// URLMapping ...
func (c *MemberRankController) URLMapping() {
	c.Mapping("AddMemberRank", c.AddMemberRank)
	c.Mapping("DeleteMemberRank", c.DeleteMemberRank)
	c.Mapping("UpdateMemberRank", c.UpdateMemberRank)
	c.Mapping("GetMemberRank", c.GetMemberRank)
	c.Mapping("GetMemberRankCount", c.GetMemberRankCount)
	c.Mapping("GetAllMemberRank", c.GetAllMemberRank)
}

// @Title Add MemberRank
// @router /add [post]
func (c *MemberRankController) AddMemberRank() {
	var memberRank model_views.MemberRank

	if v := c.GetString("member_rank"); v != "" {
		_ = json.Unmarshal([]byte(v), &memberRank)
	}

	var memberRankModel models.MemberRank
	memberRankModel.Name = memberRank.Name
	memberRankModel.IsDefault = memberRank.IsDefault
	memberRankModel.IsSpecial = memberRank.IsSpecial
	memberRankModel.Amount = memberRank.Amount
	memberRankModel.Scale = memberRank.Scale

	_, err := models.AddMemberRank(&memberRankModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete MemberRank
// @router /delete [delete]
func (c *MemberRankController) DeleteMemberRank() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		err := models.DeleteMemberRank(id)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update MemberRank
// @router /update [put]
func (c *MemberRankController) UpdateMemberRank() {
	var memberRank model_views.MemberRank

	if v := c.GetString("member_rank"); v != "" {
		_ = json.Unmarshal([]byte(v), &memberRank)
	}

	memberRankModel, err := models.GetMemberRankById(memberRank.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	if memberRank.IsDefault == 1 {
		/**
		 * 只能默认一个
		 */
		cnt, err := models.GetMemberRankCount(nil)
		if err != nil {
			c.ServerError(err)
			return
		}
		l, err := models.GetAllMemberRank(nil, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}

		for _, v := range l {
			memberRank := v.(models.MemberRank)
			memberRank.IsDefault = 0
			err = models.UpdateMemberRankById(&memberRank)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	memberRankModel.Name = memberRank.Name
	memberRankModel.IsDefault = memberRank.IsDefault
	memberRankModel.IsSpecial = memberRank.IsSpecial
	memberRankModel.Amount = memberRank.Amount
	memberRankModel.Scale = memberRank.Scale
	memberRankModel.LastUpdatedBy = c.Admin.Name

	err = models.UpdateMemberRankById(memberRankModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Area
// @router /:id
func (c *MemberRankController) GetMemberRank() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	memberRank, err := models.GetMemberRankById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
		return
	}
	memberRankView := c.setMemberRankByMemberRankModel(*memberRank)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberRankView)
}

// @Title Get MemberRank Count
// @router /count
func (c *MemberRankController) GetMemberRankCount() {
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
	cnt, err := models.GetMemberRankCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title GetAllMemberRank
// @Description Get all memberRank by some filed
// @router / [get]
func (c *MemberRankController) GetAllMemberRank() {
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

	l, err := models.GetAllMemberRank(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetMemberRankCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		memberRank := v.(models.MemberRank)
		memberRankView := c.setMemberRankByMemberRankModel(memberRank)
		pageList = append(pageList, memberRankView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *MemberRankController) setMemberRankByMemberRankModel(memberRank models.MemberRank) (memberRankView model_views.MemberRank) {
	memberRankView.Id = memberRank.Id
	memberRankView.Name = memberRank.Name
	memberRankView.IsDefault = memberRank.IsDefault
	memberRankView.IsSpecial = memberRank.IsSpecial
	memberRankView.Amount = memberRank.Amount
	memberRankView.Scale = memberRank.Scale

	return memberRankView
}

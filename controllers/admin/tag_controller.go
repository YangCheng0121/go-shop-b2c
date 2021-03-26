package admin

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"github.com/astaxie/beego/logs"
	"strconv"
	"strings"
)

type TagController struct {
	BaseController
}

// URLMapping ...
func (c *TagController) URLMapping() {
	c.Mapping("AddTag", c.AddTag)
	c.Mapping("DeleteTag", c.DeleteTag)
	c.Mapping("UpdateTag", c.UpdateTag)
	c.Mapping("GetTag", c.GetTag)
	c.Mapping("GetAllTag", c.GetAllTag)
}

// @Title Add Tag
// @Description Add new tag
// @router /add [post]
func (c *TagController) AddTag() {
	var name string
	var icon string
	var memo string
	var orders int

	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// icon
	if v := c.GetString("icon"); v != "" {
		icon = v
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}

	var query = make(map[string]string)
	query["Name"] = name
	query["DeleteFlag"] = "0"

	if cnt, err := models.GetTagCount(query); err == nil && cnt > 0 {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "不能添加重复的标签")
		return
	}

	var tag models.Tag
	tag.Name = strings.Replace(name, " ", "", -1)
	tag.Icon = icon
	tag.Memo = memo
	tag.Orders = orders
	tag.CreateBy = c.Admin.Name
	_, err := models.AddTag(&tag)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete tag
// @router /delete [delete]
func (c *TagController) DeleteTag() {
	var ids []string

	// ids: x,x,x
	if v := c.GetString("ids"); v != "" {
		logs.Info("v:", v)
		ids = strings.Split(v, ",")
	}

	for _, id := range ids {
		id, _ := strconv.Atoi(id)

		tag, err := models.GetTagById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		tag.DeleteFlag = 1
		tag.LastUpdatedBy = c.Admin.Name
		err = models.UpdateTagById(tag)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Tag
// @router /update [put]
func (c *TagController) UpdateTag() {
	var id int
	var name string
	var icon string
	var memo string
	var ordres int

	// name
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}
	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// icon
	if v := c.GetString("icon"); v != "" {
		icon = v
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}
	// ordres
	if v := c.GetString("ordres"); v != "" {
		ordres, _ = strconv.Atoi(v)
	}

	tag, err := models.GetTagById(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	tag.Name = strings.Replace(name, " ", "", -1)
	tag.Icon = icon
	tag.Memo = memo
	tag.Orders = ordres
	tag.LastUpdatedBy = c.Admin.Name

	err = models.UpdateTagById(tag)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get one tag
// @router /:id [get]
func (c *TagController) GetTag() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	tag, err := models.GetTagById(id)

	if err != nil {
		c.ServerError(err)
		return
	}
	tagView := model_views.Tag{}

	tagView.Id = tag.Id
	tagView.Name = tag.Name
	tagView.Type = tag.Type
	tagView.Orders = tag.Orders
	tagView.Memo = tag.Memo
	tagView.DeleteFlag = tag.DeleteFlag
	tagView.CreationDate = tag.CreationDate

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, tagView)
}

// @Title GetAllTag
// @Description Get all tag list by some filed
// @Param	query	    query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	sortby	    query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order	    query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ...
// @Param	pageNumber	query	string	false	"Start position of result set. Must be an integer"
// @Param	pageSize	query	int	    false	"Limit the size of result set. Must be an integer"
// @router / [get]
func (c *TagController) GetAllTag() {
	var sortby []string
	var order []string
	var query = make(map[string]string)
	var pageNumber int64 = 1
	var pageSize int64 = 10

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

	query["DeleteFlag"] = "0"
	l, err := models.GetAllTag(query, nil, sortby, order, 0, pageSize)

	var pageList []interface{}
	for _, v := range l {
		tagView := model_views.Tag{}
		tag := v.(models.Tag)

		tagView.Id = tag.Id
		tagView.Name = tag.Name
		tagView.Type = tag.Type
		tagView.Orders = tag.Orders
		tagView.Memo = tag.Memo
		tagView.DeleteFlag = tag.DeleteFlag
		tagView.CreationDate = tag.CreationDate
		pageList = append(pageList, tagView)
	}

	cnt, err := models.GetTagCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

// @Title GetTagListTotalCount
// @Description Get all tag list total count
// @Param	query	    query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @router /count [get]
func (c *TagController) GetTagListTotalCount() {
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
	cnt, err := models.GetTagCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

package admin

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"github.com/astaxie/beego/utils"
	"strconv"
	"strings"
)

type ParameterController struct {
	BaseController
}

// URLMapping ...
func (c *ParameterController) URLMapping() {
	c.Mapping("AddParameter", c.AddParameter)
	c.Mapping("DeleteParameter", c.DeleteParameter)
	c.Mapping("UpdateParameter", c.UpdateParameter)
	c.Mapping("GetParameter", c.GetParameter)
	c.Mapping("GetAllParameter", c.GetAllParameter)
}

// @Title Add Parameter Group
// @router /add [post]
func (c *ParameterController) AddParameter() {
	var productCategoryId int
	var group string
	var orders int
	var names []string

	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	// group
	if v := c.GetString("group"); v != "" {
		group = v
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// names
	if v := c.GetString("names"); v != "" {
		names = strings.Split(v, ",")
	}

	var parameterGroup models.ParameterGroup
	parameterGroup.Name = group
	parameterGroup.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}
	parameterGroup.Orders = orders
	parameterGroup.CreateBy = c.Admin.Name

	id, err := models.AddParameterGroup(&parameterGroup)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 添加 Parameter
	 */
	for _, v := range names {
		parameter := &models.Parameter{}
		parameter.Name = strings.Replace(v, " ", "", -1)
		id := int(id)
		parameter.ParameterGroupId = &models.ParameterGroup{Id: id}
		parameter.CreateBy = c.Admin.Name

		_, err := models.AddParameter(parameter)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Parameter
// @router /delete [delete]
func (c *ParameterController) DeleteParameter() {
	var ids []string

	// ids: x,x,x
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, id := range ids {
		id, _ := strconv.Atoi(id)
		parameterGroup, err := models.GetParameterGroupById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		var query = make(map[string]string)
		query["DeleteFlag"] = "0"
		query["ParameterGroupId"] = strconv.Itoa(id)

		cnt, err := models.GetParameterCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		/**
		 * 删除 Parameter
		 */
		if cnt > 0 {
			parameterList, err := models.GetAllParameter(query, nil, nil, nil, 0, cnt)
			if err != nil {
				c.ServerError(err)
				return
			}

			for _, parameter := range parameterList {
				parameter := parameter.(models.Parameter)
				parameter.DeleteFlag = 1
				parameter.LastUpdatedBy = c.Admin.Name
				if err := models.UpdateParameterById(&parameter); err != nil {
					c.ServerError(err)
					return
				}
			}
		}

		/**
		 * 删除 ParameterGroup
		 */
		parameterGroup.DeleteFlag = 1
		parameterGroup.LastUpdatedBy = c.Admin.Name
		err = models.UpdateParameterGroupById(parameterGroup)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Parameter
// @router /update [put]
func (c *ParameterController) UpdateParameter() {
	var id int
	var productCategoryId int
	var group string
	var orders int
	var names []string

	// id
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}
	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	// group
	if v := c.GetString("group"); v != "" {
		group = v
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// names
	if v := c.GetString("names"); v != "" {
		names = strings.Split(v, ",")
	}

	var parameterGroup models.ParameterGroup
	parameterGroup.Id = id
	parameterGroup.Name = group
	parameterGroup.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}
	parameterGroup.Orders = orders
	parameterGroup.LastUpdatedBy = c.Admin.Name

	err := models.UpdateParameterGroupById(&parameterGroup)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 默认查询未删除
	 */
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ParameterGroupId"] = strconv.Itoa(parameterGroup.Id)
	cnt, err := models.GetParameterCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	parameterList, err := models.GetAllParameter(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var parameterGroupNames []string
	for _, v := range parameterList {
		parameter := v.(models.Parameter)
		parameterGroupNames = append(parameterGroupNames, parameter.Name)
	}

	/**
	 * 添加Parameter
	 */
	for _, name := range names {
		if in := utils.InSlice(name, parameterGroupNames); in == false {
			var parameter models.Parameter
			parameter.Name = strings.Replace(name, " ", "", -1)
			parameter.ParameterGroupId = &models.ParameterGroup{Id: parameterGroup.Id}
			parameter.CreateBy = c.Admin.Name
			if _, err = models.AddParameter(&parameter); err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除Parameter
	 */
	for _, p := range parameterList {
		p := p.(models.Parameter)
		if in := utils.InSlice(p.Name, names); in == false {
			p.DeleteFlag = 1
			p.LastUpdatedBy = c.Admin.Name
			if err = models.UpdateParameterById(&p); err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Parameter
// @router /:id [get]
func (c *ParameterController) GetParameter() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	parameterGroup, err := models.GetParameterGroupById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	parameterGroupView := c.setParameterGroupViewByParameterModel(*parameterGroup)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, parameterGroupView)
}

// @Title Get All Parameter Group
// @Description get all parameter
// @Param	query	query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields	query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	sortby	query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order	query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ..."
// @Param	limit	query	string	false	"Limit the size of result set. Must be an integer"
// @Param	offset	query	string	false	"Start position of result set. Must be an integer"
// @router / [get]
func (c *ParameterController) GetAllParameter() {
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
	l, err := models.GetAllParameterGroup(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		parameterGroup := v.(models.ParameterGroup)
		parameterGroupView := c.setParameterGroupViewByParameterModel(parameterGroup)
		pageList = append(pageList, parameterGroupView)
	}

	cnt, err := models.GetParameterGroupCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *ParameterController) setParameterViewByParameterModel(parameter models.Parameter) (parameterView model_views.Parameter) {
	parameterView.Id = parameter.Id
	parameterView.Name = parameter.Name
	parameterView.Orders = parameter.Orders
	parameterView.DeleteFlag = parameter.DeleteFlag

	return parameterView
}

func (c *ParameterController) setParameterGroupViewByParameterModel(parameterGroup models.ParameterGroup) (parameterGroupView model_views.ParameterGroup) {
	parameterGroupView.Id = parameterGroup.Id
	parameterGroupView.Name = parameterGroup.Name
	parameterGroupView.Orders = parameterGroup.Orders
	parameterGroupView.DeleteFlag = parameterGroup.DeleteFlag

	/**
	 * 获取对应的商品分类
	 */
	productCategory, err := models.GetProductCategoryById(parameterGroup.ProductCategoryId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	parameterGroupView.ProductCategory = &model_views.ParameterProductCategory{}
	parameterGroupView.ProductCategory.Id = productCategory.Id
	parameterGroupView.ProductCategory.Name = productCategory.Name
	parameterGroupView.ProductCategory.Grade = productCategory.Grade
	parameterGroupView.ProductCategory.Orders = productCategory.Orders
	parameterGroupView.ProductCategory.DeleteFlag = productCategory.DeleteFlag
	parameterGroupView.ProductCategory.IsMarketable = productCategory.IsMarketable
	parameterGroupView.ProductCategory.IsTop = productCategory.IsTop
	parameterGroupView.ProductCategory.IsShow = productCategory.IsShow

	/**
	 * 获取参数组
	 */
	var query = make(map[string]string)
	/**
	 * 默认查询未删除
	 */
	query["DeleteFlag"] = "0"
	query["ParameterGroupId"] = strconv.Itoa(parameterGroup.Id)
	parameterList, err := models.GetAllParameter(query, nil, nil, nil, 0, 0)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range parameterList {
		parameter := v.(models.Parameter)
		parameterView := c.setParameterViewByParameterModel(parameter)
		parameterGroupView.Parameter = append(parameterGroupView.Parameter, &parameterView)
	}

	return parameterGroupView
}

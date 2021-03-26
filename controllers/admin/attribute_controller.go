package admin

import (
	"github.com/astaxie/beego/utils"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type AttributeController struct {
	BaseController
}

// URLMapping ...
func (c *AttributeController) URLMapping() {
	c.Mapping("AddAttribute", c.AddAttribute)
	c.Mapping("DeleteAttribute", c.DeleteAttribute)
	c.Mapping("UpdateAttribute", c.UpdateAttribute)
	c.Mapping("GetAttribute", c.GetAttribute)
	c.Mapping("GetAllAttribute", c.GetAllAttribute)
}

// @Title Add attribute
// @router /add [post]
func (c *AttributeController) AddAttribute() {
	var name string
	var productCategoryId int
	var orders int
	var options []string

	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// options
	if v := c.GetString("options"); v != "" {
		options = strings.Split(v, ",")
	}

	var attribute models.Attribute
	attribute.Name = name
	attribute.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}
	attribute.Orders = orders

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ProductCategoryId"] = strconv.Itoa(productCategoryId)

	cnt, err := models.GetAttributeCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	attributes, err := models.GetAllAttribute(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	attribute.PropertyIndex = len(attributes)
	attribute.CreateBy = c.Admin.Name

	id, err := models.AddAttribute(&attribute)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 添加关联 attribute_option
	 */
	if len(options) > 0 {
		c.addOrDeleteAttributeOptions(int(id), nil, options)
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete attribute
// @router /delete [delete]
func (c *AttributeController) DeleteAttribute() {
	var ids []string

	// ids
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, id := range ids {
		id, _ := strconv.Atoi(id)
		options, err := models.GetAllOptionsByAttribute(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		var optionsStr []string
		for _, option := range options {
			optionsStr = append(optionsStr, option.Options)
		}

		/**
		 * 删除 attribute_option 关联
		 */
		for _, option := range options {
			c.addOrDeleteAttributeOptions(option.Attribute, optionsStr, nil)
		}
		attribute, err := models.GetAttributeById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		attribute.DeleteFlag = 1
		attribute.LastUpdatedBy = c.Admin.Name
		err = models.UpdateAttributeById(attribute)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update attribute
// @router /update [put]
func (c *AttributeController) UpdateAttribute() {
	var id int
	var name string
	var productCategoryId int
	var orders int
	var options []string
	var propertyIndex int

	// id
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}
	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// options
	if v := c.GetString("options"); v != "" {
		options = strings.Split(v, ",")
	}
	// property_index
	if v := c.GetString("property_index"); v != "" {
		propertyIndex, _ = strconv.Atoi(v)
	}

	var attribute models.Attribute
	attribute.Id = id
	attribute.Name = name
	attribute.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}
	attribute.Orders = orders
	attribute.PropertyIndex = propertyIndex

	attributeOptions, err := models.GetAllOptionsByAttribute(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	var attributeOptionsStr []string
	for _, attributeOption := range attributeOptions {
		attributeOptionsStr = append(attributeOptionsStr, attributeOption.Options)
	}

	/**
	 * 添加、删除 关联attribute_option
	 */
	c.addOrDeleteAttributeOptions(id, attributeOptionsStr, options)

	attribute.LastUpdatedBy = c.Admin.Name
	err = models.UpdateAttributeById(&attribute)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get attribute
// @router /:id [get]
func (c *AttributeController) GetAttribute() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	attribute, err := models.GetAttributeById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	attributeView := c.setAttributeViewByAttributeModel(*attribute)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, attributeView)
}

// @Title Get All Attribute
// @Description get all attribute
// @Param	query		query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields		query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	sortby		query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order		query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ..."
// @Param	pageSize	query	string	false	"PageSize the size of result set. Must be an integer"
// @Param	offset		query	string	false	"Start position of result set. Must be an integer"
// @router / [get]
func (c *AttributeController) GetAllAttribute() {
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

	/**
	 * 默认查询未删除
	 */
	query["DeleteFlag"] = "0"
	l, err := models.GetAllAttribute(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		attribute := v.(models.Attribute)
		attributeView := c.setAttributeViewByAttributeModel(attribute)

		pageList = append(pageList, attributeView)
	}

	cnt, err := models.GetAttributeCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *AttributeController) setAttributeViewByAttributeModel(attribute models.Attribute) (attributeView model_views.Attribute) {
	attributeView.Id = attribute.Id
	attributeView.Name = attribute.Name
	attributeView.PropertyIndex = attribute.PropertyIndex
	productCategory, err := models.GetProductCategoryById(attribute.ProductCategoryId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	attributeView.ProductCategory = &model_views.AttributeProductCategory{}
	attributeView.ProductCategory.Id = productCategory.Id
	attributeView.ProductCategory.Name = productCategory.Name
	attributeView.ProductCategory.Grade = productCategory.Grade
	attributeView.ProductCategory.Orders = productCategory.Orders
	attributeView.ProductCategory.DeleteFlag = productCategory.DeleteFlag
	attributeView.ProductCategory.IsMarketable = productCategory.IsMarketable
	attributeView.ProductCategory.IsTop = productCategory.IsTop
	attributeView.ProductCategory.IsShow = productCategory.IsShow

	options, err := models.GetAllOptionsByAttribute(attributeView.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, option := range options {
		attributeView.Options = append(attributeView.Options, option.Options)
	}
	attributeView.Orders = attribute.Orders

	return attributeView
}

func (c *AttributeController) addOrDeleteAttributeOptions(attribute int, options []string, nextOptions []string) {
	/**
	 * 关联 attribute_option
	 */
	for _, option := range options {
		if in := utils.InSlice(option, options); in == false {
			var attributeOption models.AttributeOption
			attributeOption.Options = strings.Replace(option, " ", "", -1)
			attributeOption.Attribute = attribute
			err := models.AddAttributeOption(&attributeOption)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除 attribute_option 关联
	 */
	for _, option := range nextOptions {
		if in := utils.InSlice(option, options); in == false {
			var attributeOption models.AttributeOption
			attributeOption.Options = option
			attributeOption.Attribute = attribute
			err := models.DeleteAttributeOption(&attributeOption)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}
}

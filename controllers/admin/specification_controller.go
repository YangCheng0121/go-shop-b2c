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

type SpecificationController struct {
	BaseController
}

// URLMapping ...
func (c *SpecificationController) URLMapping() {
	c.Mapping("AddSpecification", c.AddSpecification)
	c.Mapping("DeleteSpecification", c.DeleteSpecification)
	c.Mapping("GetSpecification", c.GetSpecification)
	c.Mapping("UpdateSpecification", c.UpdateSpecification)
	c.Mapping("GetAllBrand", c.GetAllSpecification)
}

// @Title Add specification
// @router /add [post]
func (c *SpecificationController) AddSpecification() {
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

	var specification models.Specification
	specification.Name = strings.Replace(name, " ", "", -1)
	specification.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}
	specification.Orders = orders
	specification.CreateBy = c.Admin.Name

	id, err := models.AddSpecification(&specification)
	if err != nil {
		c.ServerError(err)
		return
	}

	if len(options) > 0 {
		for _, v := range options {
			var specificationValue models.SpecificationValue
			specificationValue.Name = v
			specificationValue.SpecificationId = &models.Specification{Id: int(id)}
			if _, err = models.AddSpecificationValue(&specificationValue); err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete specification
// @router /delete [delete]
func (c *SpecificationController) DeleteSpecification() {
	var ids []string

	// ids
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	/**
	 * 先删除 specification_value 表的数据,后删除 specification 表的数据
	 */
	for _, id := range ids {
		id, _ := strconv.Atoi(id)
		var query = make(map[string]string)
		query["DeleteFlag"] = "0"
		query["SpecificationId"] = strconv.Itoa(id)

		cnt, err := models.GetSpecificationValueCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		if cnt > 0 {
			specificationValueList, err := models.GetAllSpecificationValue(query, nil, nil, nil, 0, cnt)
			if err != nil {
				c.ServerError(err)
				return
			}

			for _, specificationValue := range specificationValueList {
				specificationValue := specificationValue.(models.SpecificationValue)
				specificationValue.LastUpdatedBy = c.Admin.Name
				if err = models.UpdateSpecificationValueById(&specificationValue); err != nil {
					c.ServerError(err)
					return
				}
			}
		}

		specification, err := models.GetSpecificationById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		specification.DeleteFlag = 1
		specification.LastUpdatedBy = c.Admin.Name

		err = models.UpdateSpecificationById(specification)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update specification
// @router /update [put]
func (c *SpecificationController) UpdateSpecification() {
	var id int
	var name string
	var productCategoryId int
	var orders int
	var options []string

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

	var specification models.Specification
	specification.Id = id
	specification.Name = strings.Replace(name, " ", "", -1)
	specification.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}
	specification.Orders = orders

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["SpecificationId"] = strconv.Itoa(id)
	cnt, err := models.GetSpecificationValueCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 先添加后删除
	 */
	specificationValueList, err := models.GetAllSpecificationValue(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var specificationValueOptions []string
	for _, svl := range specificationValueList {
		svl := svl.(models.SpecificationValue)
		specificationValueOptions = append(specificationValueOptions, svl.Name)
	}
	/**
	 * 当 options 的项中不存在于 specificationValueOptions 添加
	 */
	for _, v := range options {
		in := utils.InSlice(v, specificationValueOptions)
		if in == false {
			var specificationValue models.SpecificationValue
			specificationValue.Name = v
			specificationValue.SpecificationId = &models.Specification{Id: id}
			specificationValue.LastUpdatedBy = c.Admin.Name
			if _, err = models.AddSpecificationValue(&specificationValue); err != nil {
				c.ServerError(err)
				return
			}
		}
	}
	/**
	 * 当 specificationValueList 的项中不存在于 options 删除
	 */
	for _, svl := range specificationValueList {
		svl := svl.(models.SpecificationValue)
		in := utils.InSlice(svl.Name, options)
		if in == false {
			svl.DeleteFlag = 1
			svl.LastUpdatedBy = c.Admin.Name
			if err = models.UpdateSpecificationValueById(&svl); err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	specification.LastUpdatedBy = c.Admin.Name
	err = models.UpdateSpecificationById(&specification)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get specification
// @router /:id [get]
func (c *SpecificationController) GetSpecification() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	specification, err := models.GetSpecificationById(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	specificationView := c.setSpecificationBySpecificationModel(*specification)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, specificationView)
}

// @Title Get All Specification
// @Description get all specification
// @Param	query		query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields		query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	sortby		query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order		query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ..."
// @Param	pageSize	query	string	false	"PageSize the size of result set. Must be an integer"
// @Param	offset		query	string	false	"Start position of result set. Must be an integer"
// @router / [get]
func (c *SpecificationController) GetAllSpecification() {
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
	l, err := models.GetAllSpecification(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		specification := v.(models.Specification)
		specificationView := c.setSpecificationBySpecificationModel(specification)

		pageList = append(pageList, specificationView)
	}

	cnt, err := models.GetSpecificationCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

/**
 * SpecificationModel 转为 SpecificationView
 */
func (c *SpecificationController) setSpecificationBySpecificationModel(specification models.Specification) (specificationView model_views.Specification) {
	specificationView.Id = specification.Id
	specificationView.Name = specification.Name
	specificationView.Orders = specification.Orders

	productCategory, err := models.GetProductCategoryById(specification.ProductCategoryId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	specificationView.ProductCategory = &model_views.SpecificationProductCategory{}
	specificationView.ProductCategory.Id = productCategory.Id
	specificationView.ProductCategory.Name = productCategory.Name
	specificationView.ProductCategory.Grade = productCategory.Grade
	specificationView.ProductCategory.Orders = productCategory.Orders
	specificationView.ProductCategory.IsMarketable = productCategory.IsMarketable
	specificationView.ProductCategory.IsShow = productCategory.IsShow
	specificationView.ProductCategory.IsTop = productCategory.IsTop
	specificationView.ProductCategory.DeleteFlag = productCategory.DeleteFlag

	/**
	 * 获取 specification_value 的 count
	 */
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	cnt, err := models.GetSpecificationValueCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	query["SpecificationId"] = strconv.Itoa(specification.Id)
	specificationValueList, err := models.GetAllSpecificationValue(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var options []string
	for _, v := range specificationValueList {
		v := v.(models.SpecificationValue)
		options = append(options, v.Name)
	}
	specificationView.Options = options

	return specificationView
}

package admin

import (
	brand2 "go-shop-b2c/common/brand"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type BrandController struct {
	BaseController
}

// URLMapping ...
func (c *BrandController) URLMapping() {
	c.Mapping("AddBrand", c.AddBrand)
	c.Mapping("DeleteBrand", c.DeleteBrand)
	c.Mapping("UpdateSpecification", c.UpdateBrand)
	c.Mapping("GetBrand", c.GetBrand)
	c.Mapping("GetBrandCount", c.GetBrandCount)
	c.Mapping("GetAllBrand", c.GetAllBrand)
}

// @Title Add brand
// @router /add [post]
func (c *BrandController) AddBrand() {
	var name string
	var logo string
	var brandType string
	var url string
	var orders int
	var introduction string

	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// logo
	if v := c.GetString("logo"); v != "" {
		logo = v
	}
	// brandType
	if v := c.GetString("type"); v != "" {
		brandType = v
	}
	// url
	if v := c.GetString("url"); v != "" {
		url = v
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// introduction
	if v := c.GetString("introduction"); v != "" {
		introduction = v
	}
	var brand models.Brand
	brand.Name = strings.Replace(name, " ", "", -1)
	brand.Logo = logo
	if brandModelType := brand2.GetBrandTypeByAlias(brandType); brandModelType > -1 {
		brand.Type = brandModelType
	}
	brand.Url = url
	brand.Orders = orders
	brand.Introduction = introduction
	brand.CreateBy = c.Admin.Name

	_, err := models.AddBrand(&brand)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Delete brand
// @router /delete [delete]
func (c *BrandController) DeleteBrand() {
	var ids []string

	// ids
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, id := range ids {
		id, _ := strconv.Atoi(id)

		brand, err := models.GetBrandById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		brand.DeleteFlag = 1
		brand.LastUpdatedBy = c.Admin.Name
		err = models.UpdateBrandById(brand)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update brand
// @router /update [put]
func (c *BrandController) UpdateBrand() {
	var id int
	var name string
	var logo string
	var brandType string
	var url string
	var orders int
	var introduction string

	// id
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}
	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// logo
	if v := c.GetString("logo"); v != "" {
		logo = v
	}
	// brandType
	if v := c.GetString("type"); v != "" {
		brandType = v
	}
	// url
	if v := c.GetString("url"); v != "" {
		url = v
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// introduction
	if v := c.GetString("introduction"); v != "" {
		introduction = v
	}
	brand, err := models.GetBrandById(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	brand.Name = strings.Replace(name, " ", "", -1)
	brand.Logo = logo
	if brandModelType := brand2.GetBrandTypeByAlias(brandType); brandModelType > -1 {
		brand.Type = brandModelType
	}
	brand.Url = url
	brand.Orders = orders
	brand.Introduction = introduction
	brand.LastUpdatedBy = c.Admin.Name

	err = models.UpdateBrandById(brand)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get brand
// @router /:id [get]
func (c *BrandController) GetBrand() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	brand, err := models.GetBrandById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	brandView := c.setBrandViewByBrandModel(*brand)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, brandView)
}

// @Title Get Brand Count
// @router /count [get]
func (c *BrandController) GetBrandCount() {
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
	/**
	 * 默认查询未删除
	 */
	query["DeleteFlag"] = "0"
	cnt, err := models.GetBrandtCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get All Brand
// @Description get all brand
// @Param	query		query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields		query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	sortby		query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order		query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ..."
// @Param	pageSize	query	string	false	"PageSize the size of result set. Must be an integer"
// @Param	offset		query	string	false	"Start position of result set. Must be an integer"
// @router / [get]
func (c *BrandController) GetAllBrand() {
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
	l, err := models.GetAllBrand(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		brand := v.(models.Brand)
		brandView := c.setBrandViewByBrandModel(brand)
		pageList = append(pageList, brandView)
	}

	cnt, err := models.GetBrandtCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *BaseController) setBrandViewByBrandModel(brand models.Brand) (brandView model_views.Brand) {
	brandView.Id = brand.Id
	brandView.Name = brand.Name
	brandView.Type = brand.Type
	brandView.Logo = brand.Logo
	brandView.Url = brand.Url
	brandView.Orders = brand.Orders

	return brandView
}

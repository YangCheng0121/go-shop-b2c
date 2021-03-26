package admin

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"github.com/astaxie/beego/utils"
	"strconv"
	"strings"
)

type ProductCategoryController struct {
	BaseController
}

// URLMapping ...
func (c *ProductCategoryController) URLMapping() {
	c.Mapping("AddProductCategory", c.AddProductCategory)
	c.Mapping("DeleteProductCategory", c.DeleteProductCategory)
	c.Mapping("UpdateProductCategory", c.UpdateProductCategory)
	c.Mapping("GetProductCategoryAll", c.GetAllProductCategory)
	c.Mapping("GetProductCategory", c.GetProductCategory)
}

// @Title AddProductCategory
// @Description create ProductCategory
// @Param name      body string  true   "Category name"
// @Param parent_id body int     false  "Category parent is id"
// @Param orders    body int     false  "Orders"
// @Success 201
// @Failure 500
// @router /add [post]
func (c *ProductCategoryController) AddProductCategory() {
	var name string
	var parentId int
	var orders int
	var promotions []string
	var isTop int
	var isMarketable int
	var isShow int
	var image string

	// name
	if v := c.GetString("name"); v != "" {
		name = v
		if productCategory, _ := models.GetProductCategoryByName(name); productCategory != nil {
			c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "分类名称不能重复")
			return
		}
	}
	// parentId
	if v := c.GetString("parentId"); v != "" {
		parentId, _ = strconv.Atoi(v)
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// promotions
	if v := c.GetString("promotions"); v != "" {
		promotions = strings.Split(v, ",")
	}
	// is_top
	if v := c.GetString("isTop"); v != "" {
		isTop, _ = strconv.Atoi(v)
	}
	// is_marketable
	if v := c.GetString("isMarketable"); v != "" {
		isMarketable, _ = strconv.Atoi(v)
	}
	// is_show
	if v := c.GetString("is_show"); v != "" {
		isShow, _ = strconv.Atoi(v)
	}
	// image
	if v := c.GetString("image"); v != "" {
		image = v
	}

	var productCategory models.ProductCategory

	/**
	 * 如果存在上级分类，层级则在上级分类之后
	 * 否则为顶级分类
	 */
	if parentId > 0 {
		parentProductCategory, err := models.GetProductCategoryById(parentId)
		if err != nil {
			c.ServerError(err)
			return
		}
		productCategory.ParentId = &parentProductCategory.Id
		productCategory.Grade = parentProductCategory.Grade + 1
		productCategory.TreePath = parentProductCategory.TreePath + strconv.Itoa(parentProductCategory.Id) + ","
	} else {
		productCategory.Grade = 0
		productCategory.TreePath = ","
	}
	productCategory.Name = name
	productCategory.IsTop = int8(isTop)
	productCategory.IsMarketable = int8(isMarketable)
	productCategory.IsShow = int8(isShow)
	productCategory.Image = image

	/**
	 * 排序
	 */
	if orders > 0 {
		productCategory.Orders = orders
	}

	productCategory.CreateBy = c.Admin.Name
	id, err := models.AddProductCategory(&productCategory)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 关联促销
	 */
	if len(promotions) > 0 {
		for _, p := range promotions {
			p, _ := strconv.Atoi(p)
			err := models.AddPromotionProductCategory(p, int(id))
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete ProductCategory
// @router /delete [delete]
func (c *ProductCategoryController) DeleteProductCategory() {
	var id int

	// id
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ProductCategoryId"] = strconv.Itoa(id)
	count, err := models.GetProductCount(query)

	if count > 0 && err == nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "已存在关联商品，不能删除该分类")
		return
	}

	productCategory, err := models.GetProductCategoryById(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 删除关联促销
	 */
	promotionProductCategorys, err := models.GetPromotionProductCategoryByProductCategory(productCategory.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	if len(promotionProductCategorys) > 0 {
		for _, promotionProductCategory := range promotionProductCategorys {
			err = models.DeletePromotionProductCategory(promotionProductCategory.Promotions, promotionProductCategory.ProductCategories)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除分类
	 */
	// TODO 同时需要删除子分类
	productCategory.DeleteFlag = 1
	productCategory.LastUpdatedBy = c.Admin.Name
	err = models.UpdateProductCategoryById(productCategory)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title UpdateProductCategory
// @Description Update product's category
// @Success 204
// @Failure 500
// @router /update [put]
func (c *ProductCategoryController) UpdateProductCategory() {
	var id int
	var name string
	var parentId int
	var orders int
	var promotions []string
	var isTop int
	var isMarketable int
	var isShow int
	var image string

	// id
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}
	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// parentId
	if v := c.GetString("parentId"); v != "" {
		parentId, _ = strconv.Atoi(v)
	}
	// orders
	if v := c.GetString("orders"); v != "" {
		orders, _ = strconv.Atoi(v)
	}
	// promotions
	if v := c.GetString("promotions"); v != "" {
		promotions = strings.Split(v, ",")
	}
	// is_top
	if v := c.GetString("isTop"); v != "" {
		isTop, _ = strconv.Atoi(v)
	}
	// is_marketable
	if v := c.GetString("isMarketable"); v != "" {
		isMarketable, _ = strconv.Atoi(v)
	}
	// is_show
	if v := c.GetString("isShow"); v != "" {
		isShow, _ = strconv.Atoi(v)
	}
	// image
	if v := c.GetString("image"); v != "" {
		image = v
	}

	var productCategory models.ProductCategory

	productCategory.Id = id
	/**
	 * 如果存在上级分类，层级则在上级分类之后
	 * 否则为顶级分类
	 */
	if parentId > 0 {
		parentProductCategory, err := models.GetProductCategoryById(parentId)
		if err != nil {
			c.ServerError(err)
			return
		}
		productCategory.ParentId = &parentProductCategory.Id
		productCategory.Grade = parentProductCategory.Grade + 1
		productCategory.TreePath = parentProductCategory.TreePath + strconv.Itoa(parentProductCategory.Id) + ","
	} else {
		productCategory.Grade = 0
		productCategory.TreePath = ","
	}
	productCategory.Name = name
	productCategory.IsTop = int8(isTop)
	productCategory.IsMarketable = int8(isMarketable)
	productCategory.IsShow = int8(isShow)
	productCategory.Image = image

	/**
	 * 排序
	 */
	if orders > 0 {
		productCategory.Orders = orders
	}

	err := models.UpdateProductCategoryById(&productCategory)
	if err != nil {
		c.ServerError(err)
		return
	}

	var promotionIdsStr []string
	promotionModels, err := models.GetPromotionProductCategoryByProductCategory(productCategory.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, promotion := range promotionModels {
		promotionIdStr := strconv.Itoa(promotion.Promotions)
		promotionIdsStr = append(promotionIdsStr, promotionIdStr)
	}

	/**
	 * 新增促销
	 */
	for _, idStr := range promotions {
		if in := utils.InSlice(idStr, promotionIdsStr); in == false {
			id, _ := strconv.Atoi(idStr)
			err = models.AddPromotionProductCategory(id, productCategory.Id)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除促销
	 */
	for _, idStr := range promotionIdsStr {
		if in := utils.InSlice(idStr, promotions); in == false {
			id, _ := strconv.Atoi(idStr)
			err = models.DeletePromotionProductCategory(id, productCategory.Id)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title GetOne
// @Description get ProductCategory by id
// @Param	id		path 	string	true		"The key for staticblock"
// @Success 200 {object} models.ProductCategory
// @Failure 403 :id is empty
// @router /:id [get]
func (c *ProductCategoryController) GetProductCategory() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)
	v, err := models.GetProductCategoryById(id)

	if err != nil {
		c.ServerError(err)
		return
	}

	productCategoryView := model_views.ProductCategory{}
	productCategoryView.Id = v.Id
	productCategoryView.Name = v.Name
	productCategoryView.Orders = v.Orders
	productCategoryView.Grade = v.Grade
	if v.ParentId != nil {
		parentId := *v.ParentId
		productCategoryView.ParentId = &parentId
		parentProductCategory, err := models.GetProductCategoryById(parentId)
		if err != nil {
			c.ServerError(err)
			return
		}
		productCategoryView.ParentName = parentProductCategory.Name
	} else {
		productCategoryView.ParentId = nil
	}
	productCategoryView.IsMarketable = v.IsMarketable
	productCategoryView.IsTop = v.IsTop
	productCategoryView.IsShow = v.IsShow
	productCategoryView.Image = v.Image
	productCategoryView.TreePath = v.TreePath

	/**
	 * 查询对应的 Promotion 的结果集
	 */
	if promotions, err := models.GetPromotionProductCategoryByProductCategory(v.Id); err == nil {
		for _, promotion := range promotions {
			promotionStr := strconv.Itoa(promotion.Promotions)
			productCategoryView.Promotions = append(productCategoryView.Promotions, promotionStr)
		}
	}

	productCategoryView.DeleteFlag = v.DeleteFlag

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, productCategoryView)
}

// @Title GetProductCategoryAll
// @Description Get all product category by some filed
// @router / [get]
// @Success 200 {object} model_view.ProductCategory
// @Failure 500
func (c *ProductCategoryController) GetAllProductCategory() {
	var sortby []string
	var order []string
	var query = make(map[string]string)

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
	cnt, err := models.GetProductCategoryCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllProductCategory(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		productCategoryView := model_views.ProductCategory{}
		productCategory := v.(models.ProductCategory)

		productCategoryView.Id = productCategory.Id
		productCategoryView.Name = productCategory.Name
		productCategoryView.Orders = productCategory.Orders
		productCategoryView.Grade = productCategory.Grade
		if productCategory.ParentId != nil {
			productCategoryView.ParentId = productCategory.ParentId
		} else {
			productCategoryView.ParentId = nil
		}
		productCategoryView.DeleteFlag = productCategory.DeleteFlag

		list = append(list, productCategoryView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

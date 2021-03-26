package web

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"strconv"
)

type CategoryController struct {
	JsonController
}

// URLMapping ...
func (c *CategoryController) URLMapping() {
	c.Mapping("GetRoot", c.GetRoot)
	c.Mapping("GetChildren", c.GetChildren)
}

// @Title  获取顶级分类
// @router / [get]
func (c *CategoryController) GetRoot() {
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["Grade"] = "0"

	cnt, err := models.GetProductCategoryCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	productCategoryList, err := models.GetAllProductCategory(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range productCategoryList {
		productCategory := v.(models.ProductCategory)
		productCategoryView := c.setProductCategoryViewByProductCategoryModel(productCategory)

		list = append(list, productCategoryView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title 获取子分类
// @router /children
func (c *CategoryController) GetChildren() {
	var query = make(map[string]string)
	var productCategoryId string

	if v := c.GetString("id"); v != "" {
		productCategoryId = v
	}

	query["DeleteFlag"] = "0"
	query["ParentId"] = productCategoryId

	cnt, err := models.GetProductCategoryCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	productCategoryList, err := models.GetAllProductCategory(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range productCategoryList {
		productCategory := v.(models.ProductCategory)
		productCategoryView := c.setProductCategoryChildrenViewByProductCategoryModel(productCategory)

		list = append(list, productCategoryView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

/**
 * ProductCategoryModel 转为 ProductCategoryView
 */
func (c *CategoryController) setProductCategoryChildrenViewByProductCategoryModel(productCategory models.ProductCategory) (productCategoryChildrenView model_views.ProductCategoryChildren) {
	productCategoryChildrenView.Id = productCategory.Id
	productCategoryChildrenView.Name = productCategory.Name
	productCategoryChildrenView.Orders = productCategory.Orders
	productCategoryChildrenView.Grade = productCategory.Grade
	if productCategory.ParentId != nil {
		productCategoryChildrenView.ParentId = productCategory.ParentId
	} else {
		productCategoryChildrenView.ParentId = nil
	}
	productCategoryChildrenView.Image = productCategory.Image
	productCategoryChildrenView.TreePath = productCategory.TreePath
	productCategoryChildrenView.DeleteFlag = productCategory.DeleteFlag

	/**
	 * 获取子分类
	 */
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ParentId"] = strconv.Itoa(productCategory.Id)

	cnt, err := models.GetProductCategoryCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	productCategoryList, err := models.GetAllProductCategory(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range productCategoryList {
		productCategory = v.(models.ProductCategory)
		productCategoryView := c.setProductCategoryViewByProductCategoryModel(productCategory)

		productCategoryChildrenView.Children = append(productCategoryChildrenView.Children, productCategoryView)
	}

	return productCategoryChildrenView
}

func (c *CategoryController) setProductCategoryViewByProductCategoryModel(productCategory models.ProductCategory) (productCategoryView model_views.ProductCategory) {
	productCategoryView.Id = productCategory.Id
	productCategoryView.Name = productCategory.Name
	productCategoryView.Orders = productCategory.Orders
	productCategoryView.Grade = productCategory.Grade
	if productCategory.ParentId != nil {
		productCategoryView.ParentId = productCategory.ParentId
	} else {
		productCategoryView.ParentId = nil
	}
	productCategoryView.Image = productCategory.Image
	productCategoryView.TreePath = productCategory.TreePath
	productCategoryView.DeleteFlag = productCategory.DeleteFlag

	return productCategoryView
}

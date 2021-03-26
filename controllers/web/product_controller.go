package web

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"strconv"
	"strings"
)

type ProductController struct {
	JsonController
}

// URLMapping ...
func (c *ProductController) URLMapping() {
	c.Mapping("GetProduct", c.GetProduct)
	c.Mapping("GetAllProductReview", c.GetAllProductReview)
	c.Mapping("GetAllSelectSpecification", c.GetAllSelectSpecification)
	c.Mapping("GetAllProduct", c.GetAllProduct)
}

// @Title 获取商品
// @router /:sn
func (c *ProductController) GetProduct() {
	sn := c.Ctx.Input.Param(":sn")

	product, err := models.GetProductBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}
	controller := CommonController{}
	productView := controller.SetProductViewByProductModel(*product)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, productView)
}

// @Title 获取商品评价
// @router /review [get]
func (c *ProductController) GetAllProductReview() {
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
	query["DeleteFlag"] = "0"

	l, err := models.GetAllReview(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetReviewCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		review := v.(models.Review)
		reviewView := c.setReviewByReviewModel(review)
		pageList = append(pageList, reviewView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

// @Title 获取商品选中的规格属性
// @router /specification/:id
func (c *ProductController) GetAllSelectSpecification() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	productSpecificationList, err := models.GetProductSpecificationByProducts(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	productSpecificationValueist, err := models.GetProductSpecificationValueByProducts(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range productSpecificationList {
		specification, err := models.GetSpecificationById(v.Specifications)
		if err != nil {
			c.ServerError(err)
			return
		}
		specificationView := c.setSpecificationBySpecificationModel(*specification)

		var query = make(map[string]string)
		query["DeleteFlag"] = "0"
		cnt, err := models.GetSpecificationValueCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		query["SpecificationId"] = strconv.Itoa(specification.Id)
		SpecificationValueList, err := models.GetAllSpecificationValue(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}

		var options []model_views.ProductSpecificationValues
		for _, v := range SpecificationValueList {
			v := v.(models.SpecificationValue)
			for _, s := range productSpecificationValueist {
				if s.SpecificationValues == v.Id {
					var productSpecificationValues model_views.ProductSpecificationValues
					productSpecificationValues.Value = v.Name
					productSpecificationValues.ValueId = v.Id
					productSpecificationValues.SpecificationId = specification.Id
					productSpecificationValues.SpecificationName = specification.Name
					options = append(options, productSpecificationValues)
				}
			}
		}
		specificationView.Options = options

		list = append(list, specificationView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title 获取商品列表
// @router / [get]
func (c *ProductController) GetAllProduct() {
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

	query["DeleteFlag"] = "0"

	// start position of result set
	offset := (pageNumber - 1) * pageSize

	products, err := models.GetAllProduct(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range products {
		product := v.(models.Product)
		controller := CommonController{}
		productView := controller.SetProductViewByProductModel(product)
		pageList = append(pageList, productView)
	}

	cnt, err := models.GetProductCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

/**
 * ReviewModel 转为 ReviewView
 */
func (c *ProductController) setReviewByReviewModel(review models.Review) (reviewView model_views.Review) {
	reviewView.Id = review.Id
	reviewView.Content = review.Content
	reviewView.IsShow = review.IsShow
	reviewView.Score = review.Score
	reviewView.Ip = review.Ip
	reviewView.CreationDate = review.CreationDate

	/**
	 * 会员
	 */
	member, err := models.GetMemberById(review.MemberId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	reviewView.MemberId = member.Id
	reviewView.Username = member.Username

	/**
	 * 商品
	 */
	product, err := models.GetProductById(review.ProductId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	reviewView.ProductId = product.Id
	reviewView.ProductName = product.Name

	return reviewView
}

/**
 * SpecificationModel 转为 SpecificationView
 */
func (c *ProductController) setSpecificationBySpecificationModel(specification models.Specification) (specificationView model_views.ProductSpecification) {
	specificationView.Id = specification.Id
	specificationView.Name = specification.Name

	return specificationView
}

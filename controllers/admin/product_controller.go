package admin

import (
	"encoding/json"
	"github.com/astaxie/beego/utils"
	uuid "github.com/satori/go.uuid"
	"go-shop-b2c/common/http"
	productHelper "go-shop-b2c/common/product"
	snHelper "go-shop-b2c/common/sn"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type ProductController struct {
	BaseController
}

// URLMapping ...
func (c *ProductController) URLMapping() {
	c.Mapping("AddProduct", c.AddProduct)
	c.Mapping("UpdateProduct", c.UpdateProduct)
	c.Mapping("GetProductParameters", c.GetProductParameters)
	c.Mapping("GetProductAttributes", c.GetProductAttributes)
	c.Mapping("GetProductSpecifications", c.GetProductSpecifications)
	c.Mapping("GetOneProduct", c.GetOneProduct)
	c.Mapping("GetProductCount", c.GetProductCount)
	c.Mapping("GetAllProduct", c.GetAllProduct)
}

// @Title Add Product
// @Description create Product
// @Success 201
// @Failure 500
// @router /add [post]
func (c *ProductController) AddProduct() {
	var product models.Product
	/**
	 * 雪花算法生成 sn
	 */
	sn := snHelper.GetSnTypeByAlias("product")
	node, _ := helpers.NewWorker(int64(sn))
	product.Sn = strconv.FormatInt(node.GetId(), 10)

	/**
	 * 新增商品
	 */
	c.setProductModel(&product)
	/**
	 * 新增商品属性值
	 */
	c.addOrUpdateOrDeleteProductAttributes(&product)

	product.CreateBy = c.Admin.Name
	productId, err := models.AddProduct(&product)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 新增商品促销
	 */
	c.addOrUpdateOrDeleteProductPromotions(int(productId))

	/**
	 * 新增商品标签
	 */
	c.addOrUpdateOrDeleteProductTags(int(productId))

	/**
	 * 新增商品参数组和参数
	 */
	c.addOrUpdateOrDeleteProductParameter(int(productId), product.ProductCategoryId.Id)

	/**
	 * 新增商品图片
	 */
	c.addOrUpdateOrDeleteProductImages(int(productId))

	/**
	 * 新增商品属性
	 */
	c.addOrUpdateOrDeleteProductAttributes(&product)

	/**
	 * 更新商品规格
	 */
	c.updateProductSpecifications()

	/**
	 * 新增商品规格和规格值关联
	 */
	c.addOrDeleteProductSpecificationValue(int(productId))

	/**
	 * 添加 SKU
	 */
	c.addOrUpdateOrDeleteProductSkus(int(productId))

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Product
// @router /delete [delete]
func (c *ProductController) DeleteProduct() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, id := range ids {
		id, _ := strconv.Atoi(id)
		product, err := models.GetProductById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		/**
		 * 删除 SKU
		 */
		var query = make(map[string]string)
		query["DeleteFlag"] = "0"
		cnt, err := models.GetSkuCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		query["ProductId"] = strconv.Itoa(id)
		skus, err := models.GetAllSku(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}
		for _, sku := range skus {
			sku := sku.(models.Sku)
			sku.DeleteFlag = 1
			sku.LastUpdatedBy = c.Admin.Name
			err = models.UpdateSkuById(&sku)
			if err != nil {
				c.ServerError(err)
				return
			}
		}

		/**
		 * 删除 ProductSpecificationValue 关联
		 */
		if specificationValues, err := models.GetProductSpecificationValueByProducts(id); err == nil {
			for _, specificationValue := range specificationValues {
				err = models.DeleteProductSpecificationValue(specificationValue.Products, specificationValue.SpecificationValues)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}

		/**
		 * 删除 ProductSpecification 关联
		 */
		if specifications, err := models.GetProductSpecificationByProducts(id); err == nil {
			for _, specification := range specifications {
				err = models.DeleteProductSpecification(specification.Products, specification.Specifications)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}

		/**
		 * 删除 ProductParameterValue 关联
		 */
		if parameterValues, err := models.GetProductParameterValueByProduct(id); err == nil {
			for _, parameter := range parameterValues {
				err = models.DeleteProductParameterValue(parameter.Product, parameter.ParameterValueKey)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}

		/**
		 * 删除 Tag 关联
		 */
		if tags, err := models.GetProductTagByProducts(id); err == nil {
			for _, tag := range tags {
				err = models.DeleteProductTag(id, tag.Tags)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}

		/**
		 * 取消 Promotion 关联
		 */
		if promotions, err := models.GetPromotionProductByProducts(id); err == nil {
			for _, promotion := range promotions {
				err = models.DeletePromotionProduct(promotion.Promotions, id)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}

		/**
		 * 删除 Product
		 */
		product.DeleteFlag = 1
		product.LastUpdatedBy = c.Admin.Name
		err = models.UpdateProductById(product)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title UpdateProduct
// @Description Update product by some field
// @Param   id			path    string          true    "The id you want to update"
// @Param	body		body 	models.Product	true	"body for Product content"
// @router  /update [put]
// @Success 200 nil
// @Fail    500
func (c *ProductController) UpdateProduct() {
	var id int

	// id
	if v := c.GetString("id"); v != "" {
		id, _ = strconv.Atoi(v)
	}

	product, err := models.GetProductById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	productId := product.Id
	/**
	 * 更新商品属性
	 */
	c.setProductModel(product)

	/**
	 * 新增、更新、删除商品促销
	 */
	c.addOrUpdateOrDeleteProductPromotions(productId)

	/**
	 * 新增、更新、删除商品标签
	 */
	c.addOrUpdateOrDeleteProductTags(productId)

	/**
	 * 新增、更新、删除商品参数组和参数
	 */
	c.addOrUpdateOrDeleteProductParameter(productId, product.ProductCategoryId.Id)

	/**
	 * 新增、更新、删除商品图片
	 */
	c.addOrUpdateOrDeleteProductImages(productId)

	/**
	 * 更新商品属性值
	 */
	c.addOrUpdateOrDeleteProductAttributes(product)

	/**
	 * 商品规格
	 */
	c.updateProductSpecifications()

	product.LastUpdatedBy = c.Admin.Name
	err = models.UpdateProductById(product)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 新增、删除商品规格关联
	 */
	c.addOrDeleteProductSpecificationValue(productId)

	/**
	 * 新增、更新、删除商品SKU
	 */
	c.addOrUpdateOrDeleteProductSkus(productId)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Toggle Marketable Product
// @router /update/marketable [put]
func (c *ProductController) ToggleMarketableProduct() {
	var ids []string
	var isMarketable int
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}
	if v := c.GetString("isMarketable"); v != "" {
		isMarketable, _ = strconv.Atoi(v)
	}
	for _, id := range ids {
		id, _ := strconv.Atoi(id)
		product, err := models.GetProductById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		product.IsMarketable = int8(isMarketable)
		product.LastUpdatedBy = c.Admin.Name
		err = models.UpdateProductById(product)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get One Product
// @router /:sn
func (c *ProductController) GetOneProduct() {
	sn := c.Ctx.Input.Param(":sn")

	product, err := models.GetProductBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}
	productView := c.setProductViewByProductModel(product)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, productView)
}

// @Title Get Product Count
// @router /count
func (c *ProductController) GetProductCount() {
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
	cnt, err := models.GetProductCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get Product Parameters
// @router /parameters [get]
func (c *ProductController) GetProductParameters() {
	var productCategoryId int
	var query = make(map[string]string)

	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	/**
	 * 默认查询未删除的
	 */
	query["DeleteFlag"] = "0"
	cnt, err := models.GetParameterGroupCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	query["ProductCategoryId"] = strconv.Itoa(productCategoryId)
	l, err := models.GetAllParameterGroup(query, nil, nil, nil, 0, cnt)

	var list []interface{}
	for _, v := range l {
		productParameterGroupView := model_views.ProductParameterGroup{}
		parameterGroup := v.(models.ParameterGroup)

		productParameterGroupView.Id = parameterGroup.Id
		productParameterGroupView.Group = parameterGroup.Name
		productParameterGroupView.ProductCategoryId = parameterGroup.ProductCategoryId.Id
		productParameterGroupView.Orders = parameterGroup.Orders
		productParameterGroupView.DeleteFlag = parameterGroup.DeleteFlag

		query := make(map[string]string)
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
		for _, p := range parameterList {
			productParameterView := model_views.ProductParameter{}
			parameter := p.(models.Parameter)

			productParameterView.Id = parameter.Id
			productParameterView.Name = parameter.Name
			productParameterView.Orders = parameter.Orders
			productParameterView.DeleteFlag = parameter.DeleteFlag

			productParameterGroupView.Names = append(productParameterGroupView.Names, productParameterView)
		}

		list = append(list, productParameterGroupView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get Product Attributes
// @router /attributes
func (c *ProductController) GetProductAttributes() {
	var productCategoryId int
	var query = make(map[string]string)

	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	/**
	 * 默认查询未删除的
	 */
	query["DeleteFlag"] = "0"
	cnt, err := models.GetAttributeCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	query["ProductCategoryId"] = strconv.Itoa(productCategoryId)
	l, err := models.GetAllAttribute(query, nil, nil, nil, 0, cnt)

	var list []interface{}
	for _, v := range l {
		attributeView := model_views.Attribute{}
		attribute := v.(models.Attribute)

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

		list = append(list, attributeView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get Product Specifications
// @router /specifications
func (c *ProductController) GetProductSpecifications() {
	var productCategoryId int
	var query = make(map[string]string)

	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	/**
	 * 默认查询未删除的
	 */
	query["DeleteFlag"] = "0"
	cnt, err := models.GetSpecificationCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	query["ProductCategoryId"] = strconv.Itoa(productCategoryId)
	l, err := models.GetAllSpecification(query, nil, nil, nil, 0, cnt)

	var list []interface{}
	for _, v := range l {
		specificationView := model_views.ProductSpecification{}
		specification := v.(models.Specification)

		specificationView.Id = specification.Id
		specificationView.Name = specification.Name

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
			var productSpecificationValues model_views.ProductSpecificationValues
			productSpecificationValues.Value = v.Name
			productSpecificationValues.ValueId = v.Id
			productSpecificationValues.SpecificationId = specification.Id
			productSpecificationValues.SpecificationName = specification.Name
			options = append(options, productSpecificationValues)
		}
		specificationView.Options = options

		list = append(list, specificationView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title GetAllProduct
// @Description Get all product list by some filed
// @Param	query	    query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	sortby	    query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order	    query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ...
// @Param	pageNumber	query	string	false	"Start position of result set. Must be an integer"
// @Param	pageSize	query	int	    false	"Limit the size of result set. Must be an integer"
// @router / [get]
// @Success 200 {object} model_views.Product
// @Failure 500
func (c *ProductController) GetAllProduct() {
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
				c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "Error: invalid query key/value pair")
				return
			}
			k, v := kv[0], kv[1]
			if k == "Type" {
				v = strconv.Itoa(productHelper.GetProductTypeByAlias(v))
			}
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

	/**
	 * 默认查询未删除
	 */
	query["DeleteFlag"] = "0"
	// start position of result set
	offset := (pageNumber - 1) * pageSize
	if query["Tag"] != "" || query["Promotions"] != "" || query["Stock__gt"] != "" || query["Stock"] != "" {
		l, err := models.GetAllProductByOtherFiled(query, offset, pageSize)
		if err != nil {
			c.ServerError(err)
			return
		}
		/**
		 * 只返回前端需要的字段
		 */
		var pageList []interface{}
		for _, v := range l {
			product := v
			productView := c.setProductViewByProductModel(&product)
			pageList = append(pageList, productView)
		}

		cnt, err := models.GetProductByOtherFiled(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		pages, _ := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
	} else {
		l, err := models.GetAllProduct(query, nil, sortby, order, offset, pageSize)
		if err != nil {
			c.ServerError(err)
			return
		}

		var pageList []interface{}
		for _, v := range l {
			product := v.(models.Product)
			productView := c.setProductViewByProductModel(&product)
			pageList = append(pageList, productView)
		}

		cnt, err := models.GetProductCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		pages, _ := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
	}
}

/**
 * ProductModel 转为 ProductView
 */
func (c *ProductController) setProductViewByProductModel(product *models.Product) (productView model_views.Product) {
	productView = model_views.Product{}
	productView.Id = product.Id
	productView.Sn = product.Sn
	productView.Name = product.Name
	productView.Caption = product.Caption
	/**
	 * 分类
	 */
	productCategory, err := models.GetProductCategoryById(product.ProductCategoryId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	productView.ProductCategoryId = productCategory.Id
	productView.ProductCategoryName = productCategory.Name
	productView.IsMarketable = product.IsMarketable
	productView.IsList = product.IsList
	productView.IsTop = product.IsTop
	productView.IsDelivery = product.IsDelivery
	productView.Unit = product.Unit
	productView.Weight = product.Weight

	brand, err := models.GetBrandById(product.BrandId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	productView.BrandId = brand.Id
	productView.BrandName = brand.Name

	productView.Type = productHelper.GetProductTypeName(product.Type)
	productView.CreationDate = product.CreationDate
	productView.Memo = product.Memo
	productView.Keyword = product.Keyword
	productView.SeoKeywords = product.SeoKeywords
	productView.SeoTitle = product.SeoTitle
	productView.SeoDescription = product.SeoDescription
	productView.Introduction = product.Introduction

	productView.AttributeValue0 = product.AttributeValue0
	productView.AttributeValue1 = product.AttributeValue1
	productView.AttributeValue2 = product.AttributeValue2
	productView.AttributeValue3 = product.AttributeValue3
	productView.AttributeValue4 = product.AttributeValue4
	productView.AttributeValue5 = product.AttributeValue5
	productView.AttributeValue6 = product.AttributeValue6
	productView.AttributeValue7 = product.AttributeValue7
	productView.AttributeValue8 = product.AttributeValue8
	productView.AttributeValue9 = product.AttributeValue9
	productView.AttributeValue10 = product.AttributeValue10
	productView.AttributeValue11 = product.AttributeValue11
	productView.AttributeValue12 = product.AttributeValue12
	productView.AttributeValue13 = product.AttributeValue13
	productView.AttributeValue14 = product.AttributeValue14
	productView.AttributeValue15 = product.AttributeValue15
	productView.AttributeValue16 = product.AttributeValue16
	productView.AttributeValue17 = product.AttributeValue17
	productView.AttributeValue18 = product.AttributeValue18
	productView.AttributeValue19 = product.AttributeValue19

	if product.Image != "" {
		productView.Image = &model_views.Image{
			Uid:      uuid.Must(uuid.NewV4(), nil),
			Name:     product.Image,
			Status:   "done",
			ThumbUrl: product.Image,
			Source:   product.Image,
			Large:    product.Image,
			Medium:   product.Image,
			Url:      product.Image,
		}
	}

	/**
	 * 标签
	 */
	tags, err := models.GetProductTagByProducts(product.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range tags {
		productView.Tags = append(productView.Tags, v.Tags)
	}

	/**
	 * 促销
	 */
	promotions, err := models.GetPromotionProductByProducts(product.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range promotions {
		promotionView := model_views.Promotion{}
		promotion, err := models.GetPromotionById(v.Promotions)
		if err != nil {
			c.ServerError(err)
			return
		}
		promotionView.Id = promotion.Id
		promotionView.Name = promotion.Name
		promotionView.Title = promotion.Title
		promotionView.Orders = promotion.Orders
		promotionView.Introduction = promotion.Introduction
		promotionView.BeginDate = promotion.BeginDate
		promotionView.EndDate = promotion.EndDate
		promotionView.IsCouponAllowed = promotion.IsCouponAllowed
		promotionView.IsFreeShipping = promotion.IsFreeShipping
		promotionView.MaximumPrice = promotion.MaximumPrice
		promotionView.MaximumQuantity = promotion.MaximumQuantity
		promotionView.MinimumPrice = promotion.MinimumPrice
		promotionView.MinimumQuantity = promotion.MinimumQuantity
		promotionView.PointExpression = promotion.PointExpression
		promotionView.PriceExpression = promotion.PriceExpression
		productView.Promotions = append(productView.Promotions, promotionView)
	}

	/**
	 * 商品图片
	 */
	var qurey = make(map[string]string)
	qurey["DeleteFlag"] = "0"

	cnt, err := models.GetProductImageCount(qurey)
	if err != nil {
		c.ServerError(err)
		return
	}

	qurey["ProductId"] = strconv.Itoa(product.Id)
	productImages, err := models.GetAllProductImage(qurey, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	if len(productImages) > 0 {
		for _, image := range productImages {
			image := image.(models.ProductImage)

			var imageView model_views.Image
			imageView.Id = image.Id
			imageView.Uid = uuid.Must(uuid.NewV4(), nil)
			imageView.Name = image.Source
			imageView.Source = image.Source
			imageView.Large = image.Large
			imageView.Medium = image.Medium
			imageView.ThumbUrl = image.Thumbnail
			imageView.Url = image.Thumbnail
			imageView.Status = "done"

			productView.ProductImages = append(productView.ProductImages, imageView)
		}
	}

	/**
	 * 商品参数
	 */
	parameterValues, err := models.GetProductParameterValueByProduct(product.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	if len(parameterValues) > 0 {
		for _, parameterValue := range parameterValues {
			var parameterValueView model_views.ProductParameterValue
			parameterValueView.Id = parameterValue.ParameterValueKey
			parameterValueView.Value = parameterValue.ParameterValue
			productView.Parameters = append(productView.Parameters, parameterValueView)
		}
	}

	/**
	 * SKU
	 */
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	cnt, err = models.GetSkuCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	query["ProductId"] = strconv.Itoa(product.Id)
	skus, err := models.GetAllSku(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, sku := range skus {
		sku := sku.(models.Sku)
		skuView := model_views.ProductSku{}
		skuView.Id = sku.Id
		skuView.Sn = sku.Sn
		skuView.SpecificationValues = sku.SpecificationValues
		skuView.ProductId = sku.ProductId.Id
		skuView.RewardPoint = sku.RewardPoint
		skuView.ExchangePoint = sku.ExchangePoint
		skuView.Stock = sku.Stock
		skuView.Cost = sku.Cost
		skuView.Price = sku.Price
		skuView.MarketPrice = sku.MarketPrice
		skuView.IsDefault = sku.IsDefault
		skuView.IsEnable = sku.IsEnable

		productView.Skus = append(productView.Skus, skuView)
	}

	return productView
}

/**
 * 设置 ProductModel 的属性
 */
func (c *ProductController) setProductModel(product *models.Product) {
	var productCategoryId int
	var productType string
	var name string
	var caption string
	var image string
	var unit string
	var brandId int
	var isTop int
	var isMarketable int
	var isList int
	var introduction string
	var memo string
	var keyword string
	var seoTitle string
	var seoKeywords string
	var seoDescription string

	// productCategoryId
	if v := c.GetString("productCategoryId"); v != "" {
		productCategoryId, _ = strconv.Atoi(v)
	}
	// productType
	if v := c.GetString("productType"); v != "" {
		productType = v
	}
	// name
	if v := c.GetString("name"); v != "" {
		name = v
	}
	// image
	if v := c.GetString("image"); v != "" {
		image = v
	}
	// caption
	if v := c.GetString("caption"); v != "" {
		caption = v
	}
	// unit
	if v := c.GetString("unit"); v != "" {
		unit = v
	}
	// brandId
	if v := c.GetString("brandId"); v != "" {
		brandId, _ = strconv.Atoi(v)
	}
	// is_top
	if v := c.GetString("is_top"); v != "" {
		isTop, _ = strconv.Atoi(v)
	}
	// is_marketable
	if v := c.GetString("is_marketable"); v != "" {
		isMarketable, _ = strconv.Atoi(v)
	}
	// is_list
	if v := c.GetString("is_list"); v != "" {
		isList, _ = strconv.Atoi(v)
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}
	// keyword
	if v := c.GetString("keyword"); v != "" {
		keyword = v
	}
	// seoTitle
	if v := c.GetString("seoTitle"); v != "" {
		seoTitle = v
	}
	// seoKeywords
	if v := c.GetString("seoKeywords"); v != "" {
		seoKeywords = v
	}
	// seoDescription
	if v := c.GetString("seoDescription"); v != "" {
		seoDescription = v
	}
	// introduction
	if v := c.GetString("introduction"); v != "" {
		introduction = v
	}

	product.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}
	if productModelType := productHelper.GetProductTypeByAlias(productType); productModelType > -1 {
		product.Type = productModelType
	}
	product.Name = name
	product.Caption = caption
	product.Image = image
	product.Unit = unit

	brandModel, err := models.GetBrandById(brandId)
	if err != nil {
		c.ServerError(err)
		return
	}
	product.BrandId = brandModel
	product.Memo = memo
	product.Keyword = keyword
	product.SeoTitle = seoTitle
	product.SeoKeywords = seoKeywords
	product.SeoDescription = seoDescription
	product.IsTop = int8(isTop)
	product.IsMarketable = int8(isMarketable)
	product.IsList = int8(isList)
	product.Introduction = introduction
}

/**
 * 新增、更新、删除商品促销
 */
func (c *ProductController) addOrUpdateOrDeleteProductPromotions(productId int) {
	var promotions []string
	if v := c.GetString("promotions"); v != "" {
		promotions = strings.Split(v, ",")
	}
	/**
	 * 新增促销
	 */
	var promotionsStr []string
	productPromotions, err := models.GetPromotionProductByProducts(productId)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, p := range productPromotions {
		str := strconv.Itoa(p.Promotions)
		promotionsStr = append(promotionsStr, str)
	}
	for _, v := range promotions {
		if in := utils.InSlice(v, promotionsStr); in == false {
			promotion, _ := strconv.Atoi(v)
			err = models.AddPromotionProduct(promotion, productId)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除促销
	 */
	for _, v := range promotionsStr {
		if in := utils.InSlice(v, promotions); in == false {
			promotion, _ := strconv.Atoi(v)
			err = models.DeletePromotionProduct(promotion, productId)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}
}

/**
 * 新增、更新、删除商品标签
 */
func (c *ProductController) addOrUpdateOrDeleteProductTags(productId int) {
	var tags []string
	// tags
	if v := c.GetString("tags"); v != "" {
		tags = strings.Split(v, ",")
	}

	/**
	 * 新增标签
	 */
	var tagsStr []string
	productTags, err := models.GetProductTagByProducts(productId)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, t := range productTags {
		t := strconv.Itoa(t.Tags)
		tagsStr = append(tagsStr, t)
	}
	for _, v := range tags {
		if in := utils.InSlice(v, tagsStr); in == false {
			tag, _ := strconv.Atoi(v)
			err = models.AddProductTag(productId, tag)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除标签
	 */
	for _, v := range tagsStr {
		if in := utils.InSlice(v, tags); in == false {
			tag, _ := strconv.Atoi(v)
			err = models.DeleteProductTag(productId, tag)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}
}

/**
 * 新增、更新、删除商品图片
 */
func (c *ProductController) addOrUpdateOrDeleteProductImages(productId int) {
	var productImages []model_views.Image
	// productImage
	if v := c.GetString("productImages"); v != "" {
		_ = json.Unmarshal([]byte(v), &productImages)
	}

	/**
	 * 商品图片
	 */
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	cnt, err := models.GetProductImageCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	query["ProductId"] = strconv.Itoa(productId)
	productImagesModel, err := models.GetAllProductImage(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	/**
	 * 新增商品图片
	 */
	var productImagesIdsStr []string
	var nextProductImagesIdsStr []string
	for _, v := range productImagesModel {
		v := v.(models.ProductImage)
		idStr := strconv.Itoa(v.Id)
		productImagesIdsStr = append(productImagesIdsStr, idStr)
	}
	for _, v := range productImages {
		idStr := strconv.Itoa(v.Id)
		nextProductImagesIdsStr = append(nextProductImagesIdsStr, idStr)
		if in := utils.InSlice(idStr, productImagesIdsStr); in == false {
			var productImage models.ProductImage
			productImage.ProductId = &models.Product{Id: productId}
			productImage.Source = v.Source
			productImage.Large = v.Large
			productImage.Medium = v.Medium
			productImage.Thumbnail = v.ThumbUrl
			_, err = models.AddProductImage(&productImage)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除商品图片
	 */
	for _, idStr := range productImagesIdsStr {
		if in := utils.InSlice(idStr, nextProductImagesIdsStr); in == false {
			id, _ := strconv.Atoi(idStr)
			productImage, err := models.GetProductImageById(id)
			if err != nil {
				c.ServerError(err)
				return
			}
			productImage.DeleteFlag = 1
			err = models.UpdateProductImageById(productImage)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}
}

/**
 * 新增、更新、删除商品参数组和参数
 */
func (c *ProductController) addOrUpdateOrDeleteProductParameter(productId int, productCategoryId int) {
	var parameters []model_views.ProductParameterGroup
	// parameters
	if v := c.GetString("parameters"); v != "" {
		_ = json.Unmarshal([]byte(v), &parameters)
	}

	var parameterGroupIdsStr []string
	var parameterIdsStr []string

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ProductCategoryId"] = strconv.Itoa(productCategoryId)
	cnt, err := models.GetParameterGroupCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	parameterGroups, err := models.GetAllParameterGroup(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, parameterGroup := range parameterGroups {
		parameterGroup := parameterGroup.(models.ParameterGroup)
		groupIdStr := strconv.Itoa(parameterGroup.Id)
		parameterGroupIdsStr = append(parameterGroupIdsStr, groupIdStr)

		query = make(map[string]string)
		query["DeleteFlag"] = "0"
		query["ParameterGroupId"] = groupIdStr
		cnt, err = models.GetParameterCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		parametersList, err := models.GetAllParameter(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}
		for _, parameter := range parametersList {
			parameter := parameter.(models.Parameter)
			idStr := strconv.Itoa(parameter.Id)
			parameterIdsStr = append(parameterIdsStr, idStr)
		}
	}

	/**
	 * 新增商品参数组、新增参数、关联参数
	 */
	for _, group := range parameters {
		groupIdStr := strconv.Itoa(group.Id)
		/**
		 * 新增参数组
		 */
		if in := utils.InSlice(groupIdStr, parameterGroupIdsStr); in == false {
			var parameterGroup models.ParameterGroup
			parameterGroup.Name = group.Group
			parameterGroup.ProductCategoryId = &models.ProductCategory{Id: productCategoryId}

			parameterGroupId, err := models.AddParameterGroup(&parameterGroup)
			if err != nil {
				c.ServerError(err)
				return
			}

			/**
			 * 新增参数
			 */
			for _, parameter := range group.Names {
				if parameter.Name != "" {
					var parameterModel models.Parameter
					parameterModel.Name = parameter.Name
					parameterModel.ParameterGroupId = &models.ParameterGroup{Id: int(parameterGroupId)}

					_, err := models.AddParameter(&parameterModel)
					if err != nil {
						c.ServerError(err)
						return
					}
				}
			}
		}

		/**
		 * 新增参数、新增关联参数
		 */
		if in := utils.InSlice(groupIdStr, parameterGroupIdsStr); in == true {
			for _, parameter := range group.Names {
				parameterIdStr := strconv.Itoa(parameter.Id)
				if in := utils.InSlice(parameterIdStr, parameterIdsStr); in == false {
					/**
					 * 新增参数
					 */
					if parameter.Name != "" {
						var parameterModel models.Parameter
						parameterModel.Name = parameter.Name
						parameterModel.ParameterGroupId = &models.ParameterGroup{Id: group.Id}

						parameterId, err := models.AddParameter(&parameterModel)
						if err != nil {
							c.ServerError(err)
							return
						}
						/**
						 * 关联参数
						 */
						if parameter.Value != "" {
							err = models.AddProductParameterValue(productId, parameter.Value, int(parameterId))
							if err != nil {
								c.ServerError(err)
								return
							}
						}
					}
				}
			}
		}
	}

	/**
	 * 新增商品参数、更新商品参数、商品关联参数
	 */
	for _, group := range parameters {
		for _, parameter := range group.Names {
			parameterIdStr := strconv.Itoa(parameter.Id)
			if in := utils.InSlice(parameterIdStr, parameterIdsStr); in == true {
				/**
				 * 更新商品参数
				 */
				parameterModel, err := models.GetParameterById(parameter.Id)
				if err != nil {
					c.ServerError(err)
					return
				}
				if in := strings.Compare(parameterModel.Name, parameter.Name); in != 0 {
					parameterModel.Name = parameter.Name
					err = models.UpdateParameterById(parameterModel)
					if err != nil {
						c.ServerError(err)
						return
					}
				}

				productParameterValue, _ := models.GetProductParameterValueByParameterValueKey(parameterModel.Id)
				/**
				 * 新增商品关联参数
				 */
				if productParameterValue == nil {
					err = models.AddProductParameterValue(productId, parameter.Value, parameterModel.Id)
					if err != nil {
						c.ServerError(err)
						return
					}
				}
				/**
				 * 更新商品关联参数
				 */
				if productParameterValue != nil {
					if in := strings.Compare(productParameterValue.ParameterValue, parameter.Value); in != 0 {
						err = models.UpdateProductParameterValue(parameter.Value, productId, parameterModel.Id)
						if err != nil {
							c.ServerError(err)
							return
						}
					}
				}

			}
		}

	}

	/**
	 * 商品参数组更新
	 */
	for _, group := range parameters {
		groupIdStr := strconv.Itoa(group.Id)
		if in := utils.InSlice(groupIdStr, parameterGroupIdsStr); in == true {
			groupModel, err := models.GetParameterGroupById(group.Id)
			if err != nil {
				c.ServerError(err)
				return
			}

			if in := strings.Compare(groupModel.Name, group.Group); in != 0 {
				groupModel.Name = group.Group
				err = models.UpdateParameterGroupById(groupModel)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}
	}

	var nextGroupIdsStr []string
	var nextParameterIdsStr []string
	for _, group := range parameters {
		groupIdStr := strconv.Itoa(group.Id)
		nextGroupIdsStr = append(nextGroupIdsStr, groupIdStr)
		for _, parameter := range group.Names {
			parameterIdStr := strconv.Itoa(parameter.Id)
			nextParameterIdsStr = append(nextParameterIdsStr, parameterIdStr)
		}
	}

	/**
	 * 删除商品参数、删除关联商品参数
	 */
	for _, parameterIdStr := range parameterIdsStr {
		if in := utils.InSlice(parameterIdStr, nextParameterIdsStr); in == false {
			/**
			 * 删除商品参数
			 */
			parameterId, _ := strconv.Atoi(parameterIdStr)
			parameter, err := models.GetParameterById(parameterId)
			if err != nil {
				c.ServerError(err)
				return
			}
			parameter.DeleteFlag = 1
			err = models.UpdateParameterById(parameter)
			if err != nil {
				c.ServerError(err)
				return
			}

			/**
			 * 删除关联商品参数
			 */
			err = models.DeleteProductParameterValue(productId, parameterId)
			if err != nil {
				c.ServerError(err)
				return
			}

		}
	}

	/**
	 * 删除商品参数组
	 */
	for _, groupIdStr := range parameterGroupIdsStr {
		if in := utils.InSlice(groupIdStr, nextGroupIdsStr); in == false {
			groupId, _ := strconv.Atoi(groupIdStr)
			parameterGroup, err := models.GetParameterGroupById(groupId)
			if err != nil {
				c.ServerError(err)
				return
			}

			parameterGroup.DeleteFlag = 1
			err = models.UpdateParameterGroupById(parameterGroup)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}
}

/**
 * 更新商品属性值
 */
func (c *ProductController) addOrUpdateOrDeleteProductAttributes(product *models.Product) {
	var attributes model_views.ProductAttributes
	// attributes
	if v := c.GetString("attributes"); v != "" {
		_ = json.Unmarshal([]byte(v), &attributes)
	}

	product.AttributeValue0 = attributes.AttributeValue0
	product.AttributeValue1 = attributes.AttributeValue1
	product.AttributeValue2 = attributes.AttributeValue2
	product.AttributeValue3 = attributes.AttributeValue3
	product.AttributeValue4 = attributes.AttributeValue4
	product.AttributeValue5 = attributes.AttributeValue5
	product.AttributeValue6 = attributes.AttributeValue6
	product.AttributeValue7 = attributes.AttributeValue7
	product.AttributeValue8 = attributes.AttributeValue8
	product.AttributeValue9 = attributes.AttributeValue9
	product.AttributeValue10 = attributes.AttributeValue10
	product.AttributeValue11 = attributes.AttributeValue11
	product.AttributeValue12 = attributes.AttributeValue12
	product.AttributeValue13 = attributes.AttributeValue13
	product.AttributeValue14 = attributes.AttributeValue14
	product.AttributeValue15 = attributes.AttributeValue15
	product.AttributeValue16 = attributes.AttributeValue16
	product.AttributeValue17 = attributes.AttributeValue17
	product.AttributeValue18 = attributes.AttributeValue18
	product.AttributeValue19 = attributes.AttributeValue19
}

/**
 * 更新商品规格
 */
func (c *ProductController) updateProductSpecifications() {
	var specifications []model_views.ProductSpecification
	// specifications
	if v := c.GetString("specifications"); v != "" {
		_ = json.Unmarshal([]byte(v), &specifications)
	}

	/**
	 * 更新规格值
	 */
	for _, specification := range specifications {
		for _, specificationValue := range specification.Options {
			specificationValueModel, err := models.GetSpecificationValueById(specificationValue.ValueId)
			if err != nil {
				c.ServerError(err)
				return
			}
			if in := strings.Compare(specificationValueModel.Name, specificationValue.Value); in != 0 {
				specificationValueModel.Name = specificationValue.Value
				err = models.UpdateSpecificationValueById(specificationValueModel)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}
	}

	/**
	 * 更新规格
	 */
	for _, specification := range specifications {
		specificationModel, err := models.GetSpecificationById(specification.Id)
		if err != nil {
			c.ServerError(err)
			return
		}

		if in := strings.Compare(specificationModel.Name, specification.Name); in != 0 {
			specificationModel.Name = specification.Name
			err = models.UpdateSpecificationById(specificationModel)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}
}

/**
 * 新增、删除商品规格和规格值的关联
 */
func (c *ProductController) addOrDeleteProductSpecificationValue(productId int) {
	var skus []model_views.ProductSku
	// skus
	if v := c.GetString("skus"); v != "" {
		_ = json.Unmarshal([]byte(v), &skus)
	}

	var specificationIdsStr []string
	var specificationValueIdsStr []string

	specificationsModel, err := models.GetProductSpecificationByProducts(productId)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, specification := range specificationsModel {
		idStr := strconv.Itoa(specification.Specifications)
		specificationIdsStr = append(specificationIdsStr, idStr)
	}

	specificationValuesModel, err := models.GetProductSpecificationValueByProducts(productId)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, specificationValue := range specificationValuesModel {
		idStr := strconv.Itoa(specificationValue.SpecificationValues)
		specificationValueIdsStr = append(specificationValueIdsStr, idStr)
	}

	/**
	 * 关联规格
	 */
	for _, sku := range skus {
		for _, specification := range sku.SpecificationValuesArr {
			specificationIdStr := strconv.Itoa(specification.SpecificationId)
			if in := utils.InSlice(specificationIdStr, specificationIdsStr); in == false {
				err = models.AddProductSpecification(productId, specification.SpecificationId)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}
	}

	/**
	 * 关联规格值
	 */
	for _, sku := range skus {
		for _, specification := range sku.SpecificationValuesArr {
			specificationValueIdStr := strconv.Itoa(specification.ValueId)
			if in := utils.InSlice(specificationValueIdStr, specificationValueIdsStr); in == false {
				err = models.AddProductSpecificationValue(productId, specification.ValueId)
				if err != nil {
					c.ServerError(err)
					return
				}
			}
		}
	}

	var nextSpecificationIdsStr []string
	var nextSpecificationValueIdsStr []string
	for _, sku := range skus {
		for _, specification := range sku.SpecificationValuesArr {
			specificationIdStr := strconv.Itoa(specification.SpecificationId)
			nextSpecificationIdsStr = append(nextSpecificationIdsStr, specificationIdStr)

			specificationValueIdStr := strconv.Itoa(specification.ValueId)
			nextSpecificationValueIdsStr = append(nextSpecificationValueIdsStr, specificationValueIdStr)
		}
	}

	/**
	 * 删除规格值关联
	 */
	for _, specificationValueIdStr := range specificationValueIdsStr {
		if in := utils.InSlice(specificationValueIdStr, nextSpecificationValueIdsStr); in == false {
			specificationValueId, _ := strconv.Atoi(specificationValueIdStr)
			err = models.DeleteProductSpecificationValue(productId, specificationValueId)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除规格关联
	 */
	for _, specificationIdStr := range specificationIdsStr {
		if in := utils.InSlice(specificationIdStr, nextSpecificationIdsStr); in == false {
			specificationId, _ := strconv.Atoi(specificationIdStr)
			err = models.DeleteProductSpecification(productId, specificationId)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

}

/**
 * 新增、更新、删除商品的sku
 */
func (c *ProductController) addOrUpdateOrDeleteProductSkus(productId int) {
	var skus []model_views.ProductSku
	// skus
	if v := c.GetString("skus"); v != "" {
		_ = json.Unmarshal([]byte(v), &skus)
	}

	var skuIdsStr []string
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"

	cnt, err := models.GetSkuCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	query["ProductId"] = strconv.Itoa(productId)
	skuModels, err := models.GetAllSku(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, sku := range skuModels {
		sku := sku.(models.Sku)
		idStr := strconv.Itoa(sku.Id)
		skuIdsStr = append(skuIdsStr, idStr)
	}

	/**
	 * 新增SKU
	 */
	var nextSkuIdsStr []string
	for _, sku := range skus {
		idStr := strconv.Itoa(sku.Id)
		nextSkuIdsStr = append(nextSkuIdsStr, idStr)
		if in := utils.InSlice(idStr, skuIdsStr); in == false {
			var skuModel models.Sku
			/**
			 * 雪花算法生成 sn
			 */
			sn := snHelper.GetSnTypeByAlias("product")
			node, _ := helpers.NewWorker(int64(sn))

			skuModel.Sn = strconv.FormatInt(node.GetId(), 10)
			skuModel.ProductId = &models.Product{Id: productId}
			skuModel.IsDefault = sku.IsDefault
			skuModel.IsEnable = sku.IsEnable
			skuModel.Price = sku.Price
			skuModel.MarketPrice = sku.MarketPrice
			skuModel.Cost = sku.Cost
			skuModel.Stock = sku.Stock

			var specificationValuesText string
			specificationValuesText = ","
			for _, specificationValue := range sku.SpecificationValuesArr {
				specificationValuesText += specificationValue.Value + ","
			}
			skuModel.SpecificationValues = specificationValuesText

			_, err = models.AddSku(&skuModel)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 更新SKU
	 */
	for _, sku := range skus {
		idStr := strconv.Itoa(sku.Id)
		if in := utils.InSlice(idStr, skuIdsStr); in == true {
			skuModel, err := models.GetSkuById(sku.Id)
			if err != nil {
				c.ServerError(err)
				return
			}
			skuModel.IsDefault = sku.IsDefault
			skuModel.IsEnable = sku.IsEnable
			skuModel.Price = sku.Price
			skuModel.MarketPrice = sku.MarketPrice
			skuModel.Cost = sku.Cost
			skuModel.Stock = sku.Stock

			err = models.UpdateSkuById(skuModel)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除SKU
	 */
	for _, sku := range skuModels {
		sku := sku.(models.Sku)
		idStr := strconv.Itoa(sku.Id)
		if in := utils.InSlice(idStr, nextSkuIdsStr); in == false {
			skuModel, err := models.GetSkuById(sku.Id)
			if err != nil {
				c.ServerError(err)
				return
			}

			skuModel.DeleteFlag = 1
			err = models.UpdateSkuById(skuModel)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}
}

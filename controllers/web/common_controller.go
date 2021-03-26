package web

import (
	productHelper "go-shop-b2c/common/product"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"regexp"
	"strconv"

	uuid "github.com/satori/go.uuid"
)

type CommonController struct {
	BaseController
}

/**
 * ProductModel 转 ProductView
 */
func (c *CommonController) SetProductViewByProductModel(product models.Product) (productView model_views.Product) {
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
 * CartItemModel 转为 CartItemView
 */
func (c *CommonController) SetCartItemByCartItemModel(cartItem models.CartItem) (cartItemView model_views.CartItem) {
	cartItemView.Id = cartItem.Id

	sku, err := models.GetSkuById(cartItem.SkuId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	skuView := c.setSkuViewBySkuModel(*sku)
	cartItemView.Sku = &skuView

	product, err := models.GetProductById(sku.ProductId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	controller := CommonController{}
	productView := controller.SetProductViewByProductModel(*product)
	cartItemView.Product = &productView

	cartItemView.Quantity = cartItem.Quantity
	cartItemView.CartId = cartItem.CartId.Id

	return cartItemView
}

/**
 * SkuModel 转为 SkuView
 */
func (c *CommonController) setSkuViewBySkuModel(sku models.Sku) (skuView model_views.Sku) {
	skuView.Id = sku.Id
	skuView.Sn = sku.Sn
	skuView.AllocatedStock = sku.AllocatedStock
	skuView.Stock = sku.Stock
	skuView.Price = sku.Price
	skuView.MarketPrice = sku.MarketPrice
	skuView.Cost = sku.Cost
	skuView.IsEnable = sku.IsEnable
	skuView.IsDefault = sku.IsDefault
	skuView.SpecificationValues = sku.SpecificationValues

	product, err := models.GetProductById(sku.ProductId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	skuView.ProductId = product.Id
	skuView.Name = product.Name

	return skuView
}

/**
 * ReceiverModel 转为 ReceiverVIew
 */
func (c *CommonController) setReceiverByReceiverModel(receiver models.Receiver) (receiverView model_views.Receiver) {
	receiverView.Id = receiver.Id
	receiverView.MemberId = receiver.MemberId
	receiverView.ZipCode = receiver.ZipCode
	receiverView.Phone = receiver.Phone
	receiverView.Address = receiver.Address
	receiverView.AreaId = receiver.AreaId
	receiverView.IsDefault = receiver.IsDefault
	receiverView.AreaName = receiver.AreaName
	receiverView.Consignee = receiver.Consignee

	return receiverView
}

/**
 * CouponModel 转为 CouponView
 */
func (c *CommonController) setCouponCodeByCouponCodeModel(couponCode models.CouponCode) (couponCodeView model_views.CouponCode) {
	couponCodeView.Id = couponCode.Id
	couponCodeView.MemberId = couponCode.MemberId
	couponCodeView.Code = couponCode.Code
	couponCodeView.IsUsed = couponCode.IsUsed
	couponCodeView.UsedDate = couponCode.UsedDate

	couponView := model_views.Coupon{}
	coupon, err := models.GetCouponById(couponCode.CouponId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	couponView.Id = coupon.Id
	couponView.Name = coupon.Name
	couponView.Point = coupon.Point
	couponView.IsEnabled = coupon.IsEnabled
	couponView.PriceExpression = coupon.PriceExpression
	couponView.MinimumQuantity = coupon.MinimumQuantity
	couponView.MinimumPrice = coupon.MinimumPrice
	couponView.MaximumQuantity = coupon.MaximumQuantity
	couponView.MaximumPrice = coupon.MaximumPrice
	couponView.EndDate = coupon.EndDate
	couponView.BeginDate = coupon.BeginDate
	couponView.Introduction = coupon.Introduction
	couponView.IsExchange = coupon.IsExchange
	couponView.Prefix = coupon.Prefix
	couponView.Condition = coupon.Condition

	/**
	 * 计算优惠券金额
	 */
	// Price 表达式匹配
	// price\s*-\s*\d.*
	priceExpression := coupon.PriceExpression

	pricePattern := "price\\s*-\\s*\\d.*"
	matched, _ := regexp.MatchString(pricePattern, priceExpression)
	if matched {
		// TODO 待检查测试
		reg, _ := regexp.Compile(pricePattern)
		couponView.Value, _ = strconv.ParseFloat(reg.FindString(priceExpression), 64)
	}

	// Quantity 表达式匹配
	// quantity\s*-\s*\d.*
	quantityPattern := "quantity\\s*-\\s*\\d.*"
	matched, _ = regexp.MatchString(quantityPattern, priceExpression)
	if matched {
		// TODO 待检查测试
		reg, _ := regexp.Compile(quantityPattern)
		quantity, _ := strconv.Atoi(reg.FindString(priceExpression))
		couponView.Quantity = quantity
	}

	couponCodeView.Coupon = &couponView

	return couponCodeView
}

/**
 * MemberModel 转为 MemberView
 */
func (c *CommonController) setMemberByMemberModel(member models.Member) (memberView model_views.Member) {
	memberView.Id = member.Id
	memberView.Balance = member.Balance
	memberView.Username = member.Username
	memberView.CreationDate = member.CreationDate
	memberView.Name = member.Name
	memberView.Amount = member.Amount
	memberView.Mobile = member.Mobile
	memberView.AreaId = member.AreaId
	memberView.Address = member.Address
	memberView.Phone = member.Phone
	memberView.ZipCode = member.ZipCode
	memberView.Email = member.Email
	memberView.IsEnabled = member.IsEnabled
	memberView.LoginIp = member.LoginIp
	memberView.IsLocked = member.IsLocked
	memberView.Point = member.Point
	memberView.Avatar = member.Avatar
	memberView.Birth = member.Birth
	memberView.Gender = member.Gender
	memberView.LockedDate = member.LockedDate
	memberView.LoginDate = member.LoginDate
	memberView.LoginFailureCount = member.LoginFailureCount
	memberView.RegisterIp = member.RegisterIp
	memberView.SafeKeyExpire = member.SafeKeyExpire
	memberView.SafeKeyValue = member.SafeKeyValue

	memberRank, err := models.GetMemberRankById(int(member.MemberRankId))
	if err != nil {
		c.ServerError(err)
		return
	}
	memberView.MemberRank = memberRank.Name
	memberView.MemberRankId = int64(memberRank.Id)

	memberView.AttributeValue0 = member.AttributeValue0
	memberView.AttributeValue1 = member.AttributeValue1
	memberView.AttributeValue2 = member.AttributeValue2
	memberView.AttributeValue3 = member.AttributeValue3
	memberView.AttributeValue4 = member.AttributeValue4
	memberView.AttributeValue5 = member.AttributeValue5
	memberView.AttributeValue6 = member.AttributeValue6
	memberView.AttributeValue7 = member.AttributeValue7
	memberView.AttributeValue8 = member.AttributeValue8
	memberView.AttributeValue9 = member.AttributeValue9

	return memberView
}

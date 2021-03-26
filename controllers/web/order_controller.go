package web

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	orderHelper "go-shop-b2c/common/order"
	paymentHelper "go-shop-b2c/common/payment"
	snHelper "go-shop-b2c/common/sn"
	stockHelper "go-shop-b2c/common/stock"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type OrderController struct {
	BaseController
}

// URLMapping ...
func (c *OrderController) URLMapping() {
	c.Mapping("AddOrder", c.AddOrder)
	c.Mapping("CancelOrder", c.UpdateOrder)
	c.Mapping("RefundOrder", c.RefundOrder)
	c.Mapping("CancelOrder", c.CancelOrder)
	c.Mapping("CheckoutOrder", c.CheckoutOrder)
	c.Mapping("GetOrder", c.GetOrder)
	c.Mapping("GetOrderCoupon", c.GetOrderCoupon)
	c.Mapping("GetAllShippingMethod", c.GetAllShippingMethod)
	c.Mapping("GetAllPaymentMethod", c.GetAllPaymentMethod)
	c.Mapping("GetAllOrder", c.GetAllOrder)
}

// @Title 添加订单
// @router /add [post]
func (c *OrderController) AddOrder() {
	var cartItems []string
	var code string
	var cartKey string
	var receiverId int
	var memo string
	var paymentMethodId int
	var shippingMethodId int

	// cartItems
	if v := c.GetString("cart_items"); v != "" {
		cartItems = strings.Split(v, ",")
	}
	// code
	if v := c.GetString("code"); v != "" {
		code = v
	}
	// cartKey
	if v := c.GetString("cartKey"); v != "" {
		cartKey = v
	}
	// receiverId
	if v := c.GetString("receiver_id"); v != "" {
		receiverId, _ = strconv.Atoi(v)
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}
	// paymentMethodId
	if v := c.GetString("payment_method_id"); v != "" {
		paymentMethodId, _ = strconv.Atoi(v)
	}
	// shippingMethodId
	if v := c.GetString("shipping_method_id"); v != "" {
		shippingMethodId, _ = strconv.Atoi(v)
	}

	/**
	 * 地址
	 */
	receiver, err := models.GetReceiverById(receiverId)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 获取支付插件
	 */
	paymentPlugin, err := models.GetPluginConfigByPluginIdAndIsEnabled("weixinPaymentPlugin", 1)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "微信支付插件没用启用")
		return
	}
	var weiXinPayment models.WeXinPayment
	_ = json.Unmarshal([]byte(paymentPlugin.Attributes), &weiXinPayment)

	/**
	 * 订单收货人信息
	 */
	var order models.Order
	order.Address = receiver.Address
	order.AreaName = receiver.AreaName
	order.AreaId = receiver.AreaId
	order.Consignee = receiver.Consignee
	order.Phone = receiver.Phone

	/**
	 * 订单头信息
	 */
	order.Fee, _ = strconv.ParseFloat(weiXinPayment.Fee, 64)
	order.Status = orderHelper.GetOrderStatusByAlias("pendingPayment")
	order.Memo = memo
	order.CreateBy = c.Member.Username
	/**
	 * 订单 SN
	 */
	sn := snHelper.GetSnTypeByAlias("order")
	node, _ := helpers.NewWorker(int64(sn))
	order.Sn = strconv.FormatInt(node.GetId(), 10)

	cart, err := models.GetCartByCartKey(cartKey)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 订单行信息
	 */
	var amount float64
	var weight int
	var orderItems []models.OrderItem
	var cartItemModels []models.CartItem

	for _, v := range cartItems {
		id, _ := strconv.Atoi(v)
		cartItem, err := models.GetCartItemByIdAndCartId(id, cart.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		cartItemModels = append(cartItemModels, *cartItem)

		sku, err := models.GetSkuById(cartItem.SkuId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}

		product, err := models.GetProductById(sku.ProductId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}

		/**
		 * 订单金额、重量
		 */
		weight = weight + product.Weight*cartItem.Quantity
		amount = amount + sku.Price*float64(cartItem.Quantity)

		var orderItem models.OrderItem
		orderItem.Sn = product.Sn
		orderItem.Name = product.Name
		orderItem.Price = sku.Price
		orderItem.Quantity = cartItem.Quantity
		orderItem.Thumbnail = product.Image
		orderItem.Weight = product.Weight

		orderItem.SkuId = &models.Sku{Id: sku.Id}
		orderItem.IsDelivery = 1
		orderItem.IsGift = 0

		orderItems = append(orderItems, orderItem)
	}

	order.Amount = amount
	order.Weight = weight

	/**
	 * 优惠券
	 */
	if code != "" {
		couponCode, err := models.GetCouponCodeByCode(code)
		if err != nil {
			c.ServerError(err)
			return
		}
		controller := CommonController{}
		couponCodeView := controller.setCouponCodeByCouponCodeModel(*couponCode)

		order.CouponCodeId = int64(couponCodeView.Id)
		order.CouponDiscount = couponCodeView.Coupon.Value
	}
	order.MemberId = int64(c.Member.Id)

	/**
	 * 支付方法
	 */
	paymentMethod, err := models.GetPaymentMethodById(paymentMethodId)
	if err != nil {
		c.ServerError(err)
		return
	}
	order.PaymentMethodId = int64(paymentMethod.Id)
	order.PaymentMethodName = paymentMethod.Name

	/**
	 * 发货方法
	 */
	shippingMethod, err := models.GetShippingMethodById(shippingMethodId)
	if err != nil {
		c.ServerError(err)
		return
	}
	order.ShippingMethodId = int64(shippingMethod.Id)
	order.ShippingMethodName = shippingMethod.Name

	orderId, err := models.AddOrder(&order)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 添加订单项
	 */
	for _, orderItem := range orderItems {
		orderItem.OrderId = &models.Order{Id: int(orderId)}
		_, err := models.AddOrderItem(&orderItem)
		if err != nil {
			c.ServerError(err)
			return
		}
		/**
		 * 出库
		 */
		c.outStock(orderItem)
	}

	/**
	 * 删除购物车项
	 */
	for _, cartItem := range cartItemModels {
		err = models.DeleteCartItem(cartItem.Id)
		if err != nil {
			c.ServerError(err)
			return
		}

	}

	orderView := c.setOrderViewByOrderModel(order)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, orderView)
}

// @Title 更新订单
// @router /update [put]
func (c *OrderController) UpdateOrder() {
	var sn string
	var actionType string

	// sn
	if v := c.GetString("sn"); v != "" {
		sn = v
	}
	// actionType
	if v := c.GetString("type"); v != "" {
		actionType = v
	}

	order, err := models.GetOrderBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 根据不同的 actionType 处理订单
	 */
	switch actionType {
	case "confirm":
		order.Status = orderHelper.GetOrderStatusByAlias("completed")
	case "delete":
		order.Status = orderHelper.GetOrderStatusByAlias("failed")
		order.DeleteFlag = 1
	}

	order.LastUpdatedBy = c.Member.Username

	err = models.UpdateOrderById(order)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title 取消订单
// @router /cancel [post]
func (c *OrderController) CancelOrder() {
	var sn string
	// sn
	if v := c.GetString("sn"); v != "" {
		sn = v
	}

	order, err := models.GetOrderBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	if order.Status == orderHelper.GetOrderStatusByAlias("pendingPayment") {
		c.cancelOrder(order)
		return
	}

	if order.Status == orderHelper.GetOrderStatusByAlias("pendingReview") ||
		order.Status == orderHelper.GetOrderStatusByAlias("pendingShipment") {
		c.refundOrder(order)
		return
	}

	if order.Status == orderHelper.GetOrderStatusByAlias("completed") {
		c.refundAndReturnsOrder(order)
	}
}

// @Title 订单退款
// @router /refund [post]
func (c *OrderController) RefundOrder() {
	var sn string
	// sn
	if v := c.GetString("sn"); v != "" {
		sn = v
	}

	order, err := models.GetOrderBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	if order.Status == orderHelper.GetOrderStatusByAlias("pendingReview") ||
		order.Status == orderHelper.GetOrderStatusByAlias("pendingShipment") {
		c.refundOrder(order)
		return
	}

	if order.Status == orderHelper.GetOrderStatusByAlias("completed") {
		c.refundAndReturnsOrder(order)
	}
}

// @Title 获取订单
// @router /:sn [get]
func (c *OrderController) GetOrder() {
	sn := c.Ctx.Input.Param(":sn")

	order, err := models.GetOrderBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}

	webOrder := &model_views.WebOrder{}

	orderView := c.setOrderViewByOrderModel(*order)
	webOrder.Order = orderView

	/**
	 * OrderItems
	 */
	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["OrderId"] = strconv.Itoa(orderView.Id)
	cnt, err := models.GetOrderItemCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	orderItems, err := models.GetAllOrderItem(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range orderItems {
		orderItem := v.(models.OrderItem)
		orderItemView := c.setOrderItemByOrderItemModel(orderItem)
		webOrder.OrderItems = append(webOrder.OrderItems, orderItemView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, webOrder)
}

// @Title 获取订单的优惠券
// @router /coupon [get]
func (c *OrderController) GetOrderCoupon() {
	var cartKey string
	var cartItems []string

	// cartKey
	if v := c.GetString("cart_key"); v != "" {
		cartKey = v
	}
	// cartItems
	if v := c.GetString("cart_items"); v != "" {
		cartItems = strings.Split(v, ",")
	}

	cart, err := models.GetCartByCartKey(cartKey)
	if err != nil {
		c.ServerError(err)
		return
	}

	var cartItemModels []models.CartItem
	for _, v := range cartItems {
		id, _ := strconv.Atoi(v)
		cartItemModel, err := models.GetCartItemByIdAndCartId(id, cart.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		cartItemModels = append(cartItemModels, *cartItemModel)
	}

	var cartItemTotalPrice float64 // cartItem总计
	var cartItemTotalQuantity int  // cartItem总数
	for _, v := range cartItemModels {
		sku, err := models.GetSkuById(v.SkuId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		cartItemTotalPrice = cartItemTotalPrice + sku.Price
		cartItemTotalQuantity = cartItemTotalQuantity + v.Quantity
	}

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"

	cnt, err := models.GetCouponCodeCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	query["MemberId"] = strconv.Itoa(c.Member.Id)

	couponCodeList, err := models.GetAllCouponCode(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	var orderCoupon model_views.OrderCoupon
	for _, v := range couponCodeList {
		couponCode := v.(models.CouponCode)
		coupon, err := models.GetCouponById(couponCode.CouponId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}

		/**
		 * 总计 和 总数 必须达到最低标准
		 * 总计 和 总数 必须达到最高标准之内
		 */
		controller := CommonController{}
		couponCodeView := controller.setCouponCodeByCouponCodeModel(couponCode)
		if cartItemTotalPrice >= coupon.MinimumPrice && cartItemTotalPrice <= coupon.MaximumPrice {
			if cartItemTotalQuantity >= coupon.MinimumQuantity && cartItemTotalQuantity <= coupon.MaximumQuantity {
				orderCoupon.Available = append(orderCoupon.Available, couponCodeView)
			}
		} else {
			orderCoupon.UnAvailable = append(orderCoupon.UnAvailable, couponCodeView)
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, orderCoupon)
}

// @Title 检出预订单
// @router /checkout [post]
func (c *OrderController) CheckoutOrder() {
	var cartItems []string
	var code string
	var cartKey string

	// cart_items
	if v := c.GetString("cart_items"); v != "" {
		cartItems = strings.Split(v, ",")
	} else {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "购物车项不能为空")
	}
	// code
	if v := c.GetString("code"); v != "" {
		code = v
	}
	// cartKey
	if v := c.GetString("cartKey"); v != "" {
		cartKey = v
	}

	cart, err := models.GetCartByCartKey(cartKey)
	if err != nil {
		c.ServerError(err)
		return
	}

	checkoutOrder := &model_views.CheckoutOrder{}
	checkoutOrder.CartKey = cart.CartKey
	/**
	 * 购物车项
	 */
	for _, v := range cartItems {
		id, _ := strconv.Atoi(v)
		cartItem, err := models.GetCartItemByIdAndCartId(id, cart.Id)
		if err != nil {
			c.ServerError(err)
			return
		}

		controller := CommonController{}
		cartItemView := controller.SetCartItemByCartItemModel(*cartItem)
		checkoutOrder.CartItems = append(checkoutOrder.CartItems, cartItemView)

	}
	/**
	 * 收货地址
	 */
	controller := CommonController{}
	receiver, _ := models.GetDefaultReceiverByMemberId(c.Member.Id)
	if receiver != nil {
		receiverView := controller.setReceiverByReceiverModel(*receiver)
		checkoutOrder.Receiver = &receiverView
	}

	/**
	 * 优惠券
	 */
	couponCode, _ := models.GetCouponCodeByCode(code)
	if couponCode != nil {
		couponCodeView := controller.setCouponCodeByCouponCodeModel(*couponCode)
		checkoutOrder.CouponCode = couponCodeView
	}

	/**
	 * 总金额计算
	 */
	var totalAmount float64
	for _, cartItem := range checkoutOrder.CartItems {
		totalAmount = totalAmount + float64(cartItem.Quantity)*cartItem.Sku.Price
	}
	checkoutOrder.Amount = totalAmount

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, checkoutOrder)
}

// @Title 获取订单发货数
// @router /count
func (c *OrderController) GetOrderCount() {
	var query = make(map[string]string)

	query["DeleteFlag"] = "0"
	query["MemberId"] = strconv.Itoa(c.Member.Id)

	query["Status"] = strconv.Itoa(orderHelper.GetOrderStatusByAlias("shipped"))
	cnt, err := models.GetOrderCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	orderCount := &model_views.OrderCount{}
	orderCount.Shipped = int(cnt)

	query["Status"] = strconv.Itoa(orderHelper.GetOrderStatusByAlias("pendingPayment"))
	cnt, err = models.GetOrderCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	orderCount.PendingPayment = int(cnt)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, orderCount)
}

// @Title 获取发货方式
// @router /shipping_method [get]
func (c *OrderController) GetAllShippingMethod() {
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
	cnt, err := models.GetShippingMethodCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllShippingMethod(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		shippingMethod := v.(models.ShippingMethod)
		shippingMethodView := c.setShippingMethodByShippingMethodView(shippingMethod)
		list = append(list, shippingMethodView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title 获取支付方式
// @router /payment_method [get]
func (c *OrderController) GetAllPaymentMethod() {
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
	cnt, err := models.GetPaymentMethodCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllPaymentMethod(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		paymentMethod := v.(models.PaymentMethod)
		paymentMethodView := c.setPaymentMethodByPaymentMethodModel(paymentMethod)
		list = append(list, paymentMethodView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title 获取订单列表
// @router / [get]
func (c *OrderController) GetAllOrder() {
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
	query["MemberId"] = strconv.Itoa(c.Member.Id)
	sortby = append(sortby, "CreationDate")
	order = append(order, "desc")
	l, err := models.GetAllOrder(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	orderCount, err := models.GetOrderCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		webOrder := &model_views.WebOrder{}

		order := v.(models.Order)
		orderView := c.setOrderViewByOrderModel(order)

		webOrder.Order = orderView

		/**
		 * OrderItems
		 */
		query = make(map[string]string)
		query["DeleteFlag"] = "0"
		query["OrderId"] = strconv.Itoa(orderView.Id)
		cnt, err := models.GetOrderItemCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		orderItems, err := models.GetAllOrderItem(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}
		for _, v := range orderItems {
			orderItem := v.(models.OrderItem)
			orderItemView := c.setOrderItemByOrderItemModel(orderItem)
			webOrder.OrderItems = append(webOrder.OrderItems, orderItemView)
		}

		pageList = append(pageList, webOrder)
	}

	pages, err := helpers.NewPagination(pageList, int(orderCount), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

/**
 * OrderModel 转为 OrderView
 */
func (c *OrderController) setOrderViewByOrderModel(order models.Order) (orderView model_views.Order) {
	orderView.Id = order.Id
	orderView.AreaName = order.AreaName
	orderView.Amount = order.Amount
	orderView.AmountPaid = order.AmountPaid
	orderView.AreaId = order.AreaId
	orderView.AreaName = order.AreaName
	orderView.Address = order.Address

	/**
	 * 优惠券
	 */
	if order.CouponCodeId > 0 {
		coupon, err := models.GetCouponById(int(order.CouponCodeId))
		if err != nil {
			c.ServerError(err)
			return
		}
		orderView.CouponName = coupon.Name
		orderView.CouponCodeId = order.CouponCodeId
		orderView.CouponDiscount = order.CouponDiscount
	}

	orderView.Consignee = order.Consignee
	orderView.CompleteDate = order.CompleteDate
	orderView.CreationDate = order.CreationDate
	orderView.ExchangePoint = order.ExchangePoint
	orderView.Expire = order.Expire
	orderView.Fee = order.Fee
	orderView.Freight = order.Freight
	orderView.InvoiceContent = order.InvoiceContent
	orderView.InvoiceTitle = order.InvoiceTitle
	orderView.IsAllocatedStock = order.IsAllocatedStock
	orderView.IsExchangePoint = order.IsExchangePoint
	orderView.IsNotify = order.IsNotify
	orderView.IsUseCouponCode = order.IsUseCouponCode
	orderView.LockExpire = order.LockExpire
	orderView.LockKey = order.LockKey

	member, err := models.GetMemberById(int(order.MemberId))
	if err != nil {
		c.ServerError(err)
		return
	}
	orderView.Member = member.Username
	orderView.MemberId = int64(member.Id)
	rank, err := models.GetMemberRankById(int(member.MemberRankId))
	if err != nil {
		c.ServerError(err)
		return
	}
	orderView.MemberRank = rank.Name
	orderView.Memo = order.Memo
	orderView.OffsetAmount = order.OffsetAmount

	/**
	 * 支付方法、支付类型
	 */
	orderView.PaymentMethodId = order.PaymentMethodId
	orderView.PaymentMethodName = order.PaymentMethodName
	orderView.PaymentMethodType = order.PaymentMethodType
	orderView.PaymentMethodTypeName = paymentHelper.GetPaymentMethodName(order.PaymentMethodType)

	orderView.Phone = order.Phone
	orderView.Price = order.Price
	orderView.PromotionDiscount = order.PromotionDiscount
	orderView.PromotionName = order.PromotionName
	orderView.Quantity = order.Quantity
	orderView.RefundAmount = order.RefundAmount
	orderView.RewardPoint = order.RewardPoint
	orderView.ReturnedQuantity = order.ReturnedQuantity
	orderView.ShippingMethodId = order.ShippingMethodId
	orderView.ShippingMethodName = order.ShippingMethodName
	orderView.ShippedQuantity = order.ShippedQuantity
	orderView.ShippingDate = order.ShippingDate
	orderView.DeliveryCorpId = order.DeliveryCorpId
	orderView.DeliveryCorpName = order.DeliveryCorpName
	orderView.Sn = order.Sn
	orderView.Status = order.Status
	orderView.StatusName = orderHelper.GetOrderStatusName(order.Status)
	orderView.Tax = order.Tax
	orderView.Type = order.Type
	orderView.TypeName = orderHelper.GetOrderTypeName(order.Type)
	orderView.Weight = order.Weight
	orderView.ZipCode = order.ZipCode

	return orderView
}

/**
 * OrderItemModel 转为 OrderItemView
 */
func (c *OrderController) setOrderItemByOrderItemModel(orderItem models.OrderItem) (orderItemView model_views.OrderItem) {
	orderItemView.Id = orderItem.Id
	orderItemView.Name = orderItem.Name
	orderItemView.OrderId = orderItem.OrderId.Id
	orderItemView.Sn = orderItem.Sn
	orderItemView.Quantity = orderItem.Quantity
	orderItemView.ShippedQuantity = orderItem.ShippedQuantity
	orderItemView.ReturnQuantity = orderItem.ReturnQuantity
	orderItemView.Price = orderItem.Price
	orderItemView.Weight = orderItem.Weight
	orderItemView.Thumbnail = orderItem.Thumbnail
	orderItemView.IsGift = orderItem.IsGift
	orderItemView.IsDelivery = orderItem.IsDelivery

	sku, err := models.GetSkuById(orderItem.SkuId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	skuView := c.setSkuViewBySkuModel(sku)
	orderItemView.Sku = &skuView
	return orderItemView
}

func (c *OrderController) setSkuViewBySkuModel(sku *models.Sku) (skuView model_views.Sku) {
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
 * PaymentMethodModel 转为 PaymentMethodView
 */
func (c *OrderController) setPaymentMethodByPaymentMethodModel(paymentMethod models.PaymentMethod) (paymentMethodView model_views.PaymentMethod) {
	paymentMethodView.Id = paymentMethod.Id
	paymentMethodView.Name = paymentMethod.Name
	paymentMethodView.Orders = paymentMethod.Orders
	paymentMethodView.Icon = paymentMethod.Icon
	paymentMethodView.Description = paymentMethod.Description
	paymentMethodView.Type = paymentMethod.Type
	paymentMethodView.TypeName = paymentHelper.GetPaymentMethodTypeName(paymentMethod.Type)
	paymentMethodView.Timeout = paymentMethod.Timeout
	paymentMethodView.Content = paymentMethod.Content
	paymentMethodView.Method = paymentMethod.Method
	paymentMethodView.MethodName = paymentHelper.GetPaymentMethodName(paymentMethod.Method)

	return paymentMethodView
}

/**
 * ShippingMethodModel 转为 ShippingMethodView
 */
func (c *OrderController) setShippingMethodByShippingMethodView(shippingMethod models.ShippingMethod) (shippingMethodView model_views.ShippingMethod) {
	shippingMethodView.Id = shippingMethod.Id
	shippingMethodView.Name = shippingMethod.Name
	shippingMethodView.Orders = shippingMethod.Orders
	shippingMethodView.FirstWeight = shippingMethod.FirstWeight
	shippingMethodView.FirstPrice = shippingMethod.FirstPrice
	shippingMethodView.ContinuePrice = shippingMethod.ContinuePrice
	shippingMethodView.ContinueWeight = shippingMethod.ContinueWeight
	shippingMethodView.Icon = shippingMethod.Icon
	shippingMethodView.Description = shippingMethod.Description
	shippingMethodView.DefaultDeliveryCorpId = shippingMethod.DefaultDeliveryCorpId.Id
	paymentShippingMethods, err := models.GetPaymentShippingMethodsByShippingMethods(shippingMethod.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, paymentShippingMethod := range paymentShippingMethods {
		shippingMethodView.PaymentShippingMethods = append(shippingMethodView.PaymentShippingMethods, paymentShippingMethod.PaymentMethods)
	}

	return shippingMethodView
}

/**
 * 退货退款
 * 先退货后退款
 */
func (c *OrderController) refundOrder(order *models.Order) {
	if order.Status == orderHelper.GetOrderStatusByAlias("pendingReview") ||
		order.Status == orderHelper.GetOrderStatusByAlias("pendingShipment") {
		/**
		 * 退款
		 */
		order.Status = orderHelper.GetOrderStatusByAlias("refunding")
		refund := &models.Refunds{}

		refundSn := snHelper.GetSnTypeByAlias("refunds")
		node, _ := helpers.NewWorker(int64(refundSn))
		refund.Sn = strconv.FormatInt(node.GetId(), 10)

		refund.Amount = order.AmountPaid
		refund.OrderId = &models.Order{Id: order.Id}
		refund.PaymentMethod = order.PaymentMethodName
		refund.Method = order.PaymentMethodType
		refund.CreateBy = c.Member.Username
		refund.Operator = c.Member.Username
		refund.Payee = c.Member.Name

		weiXinPaymentPlugin := models.GetWeiXinPaymentPlugin()
		refund.Payee = weiXinPaymentPlugin.PaymentName

		_, err := models.AddRefunds(refund)
		if err != nil {
			c.ServerError(err)
			return
		}

		/**
		 * 更新订单状态
		 */
		err = models.UpdateOrderById(order)
		if err != nil {
			c.ServerError(err)
			return
		}
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, "申请退款成功!")
	} else {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "该订单不能退款")
	}
}

func (c *OrderController) refundAndReturnsOrder(order *models.Order) {
	if order.Status == orderHelper.GetOrderStatusByAlias("completed") {
		var query = make(map[string]string)
		query["DeleteFlag"] = "0"
		query["OrderId"] = strconv.Itoa(order.Id)

		orderItemCount, err := models.GetOrderItemCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		l, err := models.GetAllOrderItem(query, nil, nil, nil, 0, orderItemCount)
		if err != nil {
			c.ServerError(err)
			return
		}

		returns := &models.Returns{}
		returns.OrderId = &models.Order{Id: order.Id}
		returnsSn := snHelper.GetSnTypeByAlias("returns")
		node, _ := helpers.NewWorker(int64(returnsSn))
		returns.Sn = strconv.FormatInt(node.GetId(), 10)
		returns.Operator = c.Member.Username
		returns.CreateBy = c.Member.Username
		returns.Area = order.AreaName
		returns.Address = order.Address
		returns.ShippingMethod = order.ShippingMethodName
		returns.Phone = order.Phone
		returns.DeliveryCorp = order.DeliveryCorpName

		returnsId, err := models.AddReturns(returns)
		if err != nil {
			c.ServerError(err)
			return
		}

		for _, v := range l {
			orderItem := v.(models.OrderItem)
			returnsItem := &models.ReturnsItem{}

			returnsItem.CreateBy = c.Member.Username
			returnsItem.Sn = orderItem.Sn
			returnsItem.Name = orderItem.Name
			returnsItem.Quantity = orderItem.Quantity
			returnsItem.ReturnsId = &models.Returns{Id: int(returnsId)}

			_, err = models.AddReturnsItem(returnsItem)
			if err != nil {
				c.ServerError(err)
				return
			}
		}

		/**
		 * 退款
		 */
		order.Status = orderHelper.GetOrderStatusByAlias("refunding")
		refund := &models.Refunds{}

		refundSn := snHelper.GetSnTypeByAlias("refunds")
		node, _ = helpers.NewWorker(int64(refundSn))
		refund.Sn = strconv.FormatInt(node.GetId(), 10)

		refund.Amount = order.AmountPaid
		refund.OrderId = &models.Order{Id: order.Id}
		refund.PaymentMethod = order.PaymentMethodName
		refund.Method = order.PaymentMethodType
		refund.CreateBy = c.Member.Username
		refund.Operator = c.Member.Username
		refund.Payee = c.Member.Name

		weiXinPaymentPlugin := models.GetWeiXinPaymentPlugin()
		refund.Payee = weiXinPaymentPlugin.PaymentName

		_, err = models.AddRefunds(refund)
		if err != nil {
			c.ServerError(err)
			return
		}

		/**
		 * 更新订单状态
		 */
		err = models.UpdateOrderById(order)
		if err != nil {
			c.ServerError(err)
			return
		}

		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, "申请退款成功!")
	} else {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "该订单不能退款")
	}
}

func (c *OrderController) cancelOrder(order *models.Order) {
	order.Status = orderHelper.GetOrderStatusByAlias("canceled")
	order.LastUpdatedBy = c.Member.Username

	err := models.UpdateOrderById(order)
	if err != nil {
		c.ServerError(err)
		return
	}

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["OrderId"] = strconv.Itoa(order.Id)
	orderItemCount, err := models.GetOrderItemCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllOrderItem(query, nil, nil, nil, 0, orderItemCount)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range l {
		orderItem := v.(models.OrderItem)
		c.inStock(orderItem)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, "取消订单成功!")
}

/**
 * 入库
 */
func (c *OrderController) inStock(orderItem models.OrderItem) {
	sku, err := models.GetSkuById(orderItem.SkuId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	sku.Stock = sku.Stock + orderItem.Quantity
	orderItem.LastUpdatedBy = c.Member.Username
	err = models.UpdateSkuById(sku)
	if err != nil {
		c.ServerError(err)
		return
	}

	skuLog := &models.StockLog{}
	skuLog.CreateBy = c.Member.Username
	skuLog.SkuId = sku
	skuLog.InQuantity = orderItem.Quantity
	skuLog.Type = stockHelper.GetStockTypeByAlias("in")
	skuLog.Stock = sku.Stock
	skuLog.Memo = "订单取消/退款-入库"

	_, err = models.AddStockLog(skuLog)
	if err != nil {
		c.ServerError(err)
		return
	}
}

/**
 * 出库
 */
func (c *OrderController) outStock(orderItem models.OrderItem) {
	sku, err := models.GetSkuById(orderItem.SkuId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	sku.Stock = sku.Stock - orderItem.Quantity
	orderItem.LastUpdatedBy = c.Member.Username

	err = models.UpdateSkuById(sku)
	if err != nil {
		c.ServerError(err)
		return
	}

	skuLog := &models.StockLog{}
	skuLog.CreateBy = c.Member.Username
	skuLog.SkuId = sku
	skuLog.OutQuantity = orderItem.Quantity
	skuLog.Type = stockHelper.GetStockTypeByAlias("out")
	skuLog.Stock = sku.Stock
	skuLog.Memo = "订单下单-入库"

	_, err = models.AddStockLog(skuLog)
	if err != nil {
		c.ServerError(err)
		return
	}
}

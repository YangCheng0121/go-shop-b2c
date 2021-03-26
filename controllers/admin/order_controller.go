package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	orderHelper "go-shop-b2c/common/order"
	orderLogHelper "go-shop-b2c/common/order_log"
	paymentHelper "go-shop-b2c/common/payment"
	snHelper "go-shop-b2c/common/sn"
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
	c.Mapping("DeleteOrder", c.DeleteOrder)
	c.Mapping("UpdateOrder", c.UpdateOrder)
	c.Mapping("ReviewOrder", c.ReviewOrder)
	c.Mapping("ReceivePayment", c.ReceivePayment)
	c.Mapping("ShipOrder", c.ShipOrder)
	c.Mapping("FailOrder", c.FailOrder)
	c.Mapping("CompleteOrder", c.CompleteOrder)
	c.Mapping("GetOneOrder", c.GetOneOrder)
	c.Mapping("GetProducts", c.GetProducts)
	c.Mapping("GetLogs", c.GetLogs)
	c.Mapping("GetOrderItems", c.GetOrderItems)
	c.Mapping("GetAllOrder", c.GetAllOrder)
}

// @Title 删除订单
// @router /delete [delete]
func (c *OrderController) DeleteOrder() {
	var ids []string
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, v := range ids {
		id, _ := strconv.Atoi(v)
		order, err := models.GetOrderById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		order.DeleteFlag = 1

		err = models.UpdateOrderById(order)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// UpdateOrder ...
// @Title Update Order
// @Description Update Order by some fields
// @Param   id			path    string          true    "The id you want to update"
// @Param	body		body 	models.Product	true	"body for Product content"
// @router /update [put]
// @Success 200 nil
// @Fail    500
func (c *OrderController) UpdateOrder() {
	var order model_views.Order

	// order
	if v := c.GetString("order"); v != "" {
		_ = json.Unmarshal([]byte(v), &order)
	}

	orderModel, err := models.GetOrderById(order.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	orderModel.Freight = order.Freight
	orderModel.OffsetAmount = order.OffsetAmount
	orderModel.RewardPoint = order.RewardPoint
	orderModel.PaymentMethodId = order.PaymentMethodId
	orderModel.ShippingMethodId = order.ShippingMethodId
	orderModel.Consignee = order.Consignee
	orderModel.Address = order.Address
	orderModel.AreaId = order.AreaId
	orderModel.AreaName = order.AreaName
	orderModel.Phone = order.Phone
	orderModel.Memo = order.Memo
	orderModel.InvoiceTitle = order.InvoiceTitle
	orderModel.InvoiceContent = order.InvoiceContent
	orderModel.Tax = order.Tax
	orderModel.LastUpdatedBy = c.Admin.Name

	err = models.UpdateOrderById(orderModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Review Order
// @router /review [put]
func (c *OrderController) ReviewOrder() {
	var orderId int
	var isReview string

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId, _ = strconv.Atoi(v)
	}
	// isReview
	if v := c.GetString("is_review"); v != "" {
		isReview = v
	}

	order, err := models.GetOrderById(orderId)
	if err != nil {
		c.ServerError(err)
		return
	}

	name := orderHelper.GetOrderStatusAliasName(order.Status)
	if name != "pendingReview" {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "该订单不是等待审核")
		return
	}

	if isReview == "1" {
		/**
		 * 审核订单
		 */
		status := orderHelper.GetOrderStatusByAlias("pendingShipment")
		order.Status = status
		/**
		 * 添加订单记录
		 */
		c.addOrderLog(orderId, "review", "[订单审核:通过]-"+c.Admin.Username)
	} else {
		/**
		 * 拒绝订单
		 */
		status := orderHelper.GetOrderStatusByAlias("denied")
		order.Status = status
		/**
		 * 添加订单记录
		 */
		c.addOrderLog(orderId, "review", "[订单审核:拒绝]-"+c.Admin.Username)
	}

	err = models.UpdateOrderById(order)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Receive Payment
// @router /receive_payment [post]
func (c *OrderController) ReceivePayment() {
	var orderId int
	var bank string
	var account string
	var amount float64
	var payer string
	var method int
	var paymentMethod int
	var memo string

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId, _ = strconv.Atoi(v)
	}
	// bank
	if v := c.GetString("bank"); v != "" {
		bank = v
	}
	// account
	if v := c.GetString("account"); v != "" {
		account = v
	}
	// amount
	if v := c.GetString("amount"); v != "" {
		amount, _ = strconv.ParseFloat(v, 64)
	}
	// payer
	if v := c.GetString("payer"); v != "" {
		payer = v
	}
	// method
	if v := c.GetString("method"); v != "" {
		method, _ = strconv.Atoi(v)
	}
	// paymentMethod
	if v := c.GetString("paymentMethod"); v != "" {
		paymentMethod, _ = strconv.Atoi(v)
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}

	/**
	 * 收款
	 */
	var payment models.Payment
	sn := snHelper.GetSnTypeByAlias("payment")
	node, _ := helpers.NewWorker(int64(sn))
	payment.Sn = strconv.FormatInt(node.GetId(), 10)

	payment.Bank = bank
	payment.Account = account
	payment.Amount = amount
	payment.Payer = payer
	payment.Method = method

	paymentMethodModel, err := models.GetPaymentMethodById(paymentMethod)
	if err != nil {
		c.ServerError(err)
		return
	}

	payment.PaymentMethod = paymentMethodModel.Name
	payment.Memo = memo
	payment.CreateBy = c.Admin.Name

	_, err = models.AddPayment(&payment)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 更新订单已付金额
	 */
	order, err := models.GetOrderById(orderId)
	if err != nil {
		c.ServerError(err)
		return
	}
	order.AmountPaid = order.AmountPaid + amount

	err = models.UpdateOrderById(order)
	if err != nil {
		c.ServerError(err)
		return
	}
	/**
	 * 添加订单记录
	 */
	c.addOrderLog(orderId, "payment", c.Admin.Name)

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Ship Order
// @router /ship [post]
func (c *OrderController) ShipOrder() {
	var orderId int
	var shippingMethodId int
	var deliveryCorpId int
	var trackingNo string
	var freight float64
	var consignee string
	var area string
	var address string
	var zipCode string
	var phone string
	var memo string
	var shippingItems []model_views.ShippingItem

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId, _ = strconv.Atoi(v)
	}
	// shippingMethodId
	if v := c.GetString("shipping_method_id"); v != "" {
		shippingMethodId, _ = strconv.Atoi(v)
	}
	// deliveryCorpId
	if v := c.GetString("delivery_corp_id"); v != "" {
		deliveryCorpId, _ = strconv.Atoi(v)
	}
	// trackingNo
	if v := c.GetString("tracking_no"); v != "" {
		trackingNo = v
	}
	// freight
	if v := c.GetString("tracking_no"); v != "" {
		freight, _ = strconv.ParseFloat(v, 64)
	}
	// consignee
	if v := c.GetString("consignee"); v != "" {
		consignee = v
	}
	// area
	if v := c.GetString("area"); v != "" {
		area = v
	}
	// address
	if v := c.GetString("address"); v != "" {
		address = v
	}
	// zipCode
	if v := c.GetString("zip_code"); v != "" {
		zipCode = v
	}
	// phone
	if v := c.GetString("phone"); v != "" {
		phone = v
	}
	// memo
	if v := c.GetString("memo"); v != "" {
		memo = v
	}
	// shippingItems
	if v := c.GetString("shipping_items"); v != "" {
		_ = json.Unmarshal([]byte(v), &shippingItems)
	}

	order, err := models.GetOrderById(orderId)
	if err != nil {
		c.ServerError(err)
		return
	}
	if order.Status != orderHelper.GetOrderStatusByAlias("pendingShipment") {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "订单状态不是等待发货")
		return
	}

	/**
	 * 发货数量不能为0
	 */
	for _, v := range shippingItems {
		if v.Quantity == 0 {
			c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "发货数量不能为0")
			return
		}
	}

	/**
	 * 发货数不能大于 购买数 - 已发货数
	 */
	for _, v := range shippingItems {
		sn := v.Sn
		orderItem, err := models.GetOrderItemBySnAndOrderId(sn, orderId)
		if err != nil {
			c.ServerError(err)
			return
		}
		quantity := orderItem.Quantity - orderItem.ShippedQuantity

		if quantity < v.Quantity {
			c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "发货数不能大于 购买数 - 已发货数")
			return
		}
	}

	var shippingModel models.Shipping
	/**
	 * 雪花算法生成 sn
	 */
	sn := snHelper.GetSnTypeByAlias("ship")
	node, _ := helpers.NewWorker(int64(sn))
	shippingModel.Sn = strconv.FormatInt(node.GetId(), 10)
	shippingModel.Consignee = consignee
	shippingModel.OrderId = int64(orderId)

	deliveryCorp, err := models.GetDeliveryCorpById(deliveryCorpId)
	if err != nil {
		c.ServerError(err)
		return
	}
	shippingModel.DeliveryCorp = deliveryCorp.Name
	shippingModel.DeliveryCorpUrl = deliveryCorp.Url
	shippingModel.DeliveryCorpCode = deliveryCorp.Code
	shippingModel.TrackingNo = trackingNo
	shippingModel.Area = area
	shippingModel.Address = address
	shippingModel.ZipCode = zipCode

	shippingMethod, err := models.GetShippingMethodById(shippingMethodId)
	if err != nil {
		c.ServerError(err)
		return
	}
	shippingModel.ShippingMethod = shippingMethod.Name
	shippingModel.Memo = memo
	shippingModel.Freight = freight
	shippingModel.Phone = phone
	shippingModel.Operator = c.Admin.Name
	shippingModel.CreateBy = c.Admin.Name

	shippingId, err := models.AddShipping(&shippingModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 添加发货项
	 */
	for _, v := range shippingItems {
		shippingItem := models.ShippingItem{}
		shippingItem.Name = v.Name
		shippingItem.Sn = v.Sn
		shippingItem.Quantity = v.Quantity
		shippingItem.ShippingId = &models.Shipping{Id: int(shippingId)}
		shippingItem.IsDelivery = v.IsDelivery
		shippingItem.CreateBy = c.Admin.Name

		_, err := models.AddShippingItem(&shippingItem)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	/**
	 * 更新订单项
	 */
	for _, v := range shippingItems {
		sn := v.Sn
		orderItem, err := models.GetOrderItemBySnAndOrderId(sn, orderId)
		if err != nil {
			c.ServerError(err)
			return
		}
		orderItem.ShippedQuantity = orderItem.ShippedQuantity + v.Quantity

		err = models.UpdateOrderItemById(orderItem)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	/**
	 * 更新订单状态
	 */
	order.Status = orderHelper.GetOrderStatusByAlias("shipped")
	err = models.UpdateOrderById(order)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 添加订单记录
	 */
	c.addOrderLog(orderId, "ship", c.Admin.Name)
	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Fail Order
// @router /fail [put]
func (c *OrderController) FailOrder() {
	var orderId int

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId, _ = strconv.Atoi(v)
	}

	order, err := models.GetOrderById(orderId)
	if err != nil {
		c.ServerError(err)
		return
	}

	order.Status = orderHelper.GetOrderStatusByAlias("failed")

	err = models.UpdateOrderById(order)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.addOrderLog(order.Id, "fail", c.Admin.Name)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Complete Order
// @router /complete [put]
func (c *OrderController) CompleteOrder() {
	var orderId int

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId, _ = strconv.Atoi(v)
	}

	order, err := models.GetOrderById(orderId)
	if err != nil {
		c.ServerError(err)
		return
	}

	if order.Status != orderHelper.GetOrderStatusByAlias("shipped") {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "当前订单状态不能完成")
		return
	}

	order.Status = orderHelper.GetOrderStatusByAlias("completed")

	err = models.UpdateOrderById(order)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 添加订单记录
	 */
	c.addOrderLog(order.Id, "complete", c.Admin.Name)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get One Order
// @router /:sn [get]
func (c *OrderController) GetOneOrder() {
	sn := c.Ctx.Input.Param(":sn")

	order, err := models.GetOrderBySn(sn)
	if err != nil {
		c.ServerError(err)
		return
	}
	orderView := c.setOrderViewByOrderModel(*order)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, orderView)
}

// @Title Get Products
// @router /products [get]
func (c *OrderController) GetProducts() {
	var orderId string
	var sortby []string
	var order []string

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId = v
	}
	// sortby: col1,col2
	if v := c.GetString("sortby"); v != "" {
		sortby = strings.Split(v, ",")
	}
	// order: desc,asc
	if v := c.GetString("order"); v != "" {
		order = strings.Split(v, ",")
	}

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["OrderId"] = orderId

	cnt, err := models.GetOrderItemCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllOrderItem(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, orderItem := range l {
		orderItem := orderItem.(models.OrderItem)
		orderItemView := &model_views.OrderItem{}

		orderItemView.Id = orderItem.Id
		orderItemView.Name = orderItem.Name
		orderItemView.Weight = orderItem.Weight
		orderItemView.Price = orderItem.Price
		orderItemView.ShippedQuantity = orderItem.ShippedQuantity
		orderItemView.ReturnQuantity = orderItem.ReturnQuantity
		orderItemView.OrderId = orderItem.OrderId.Id
		orderItemView.Sn = orderItem.Sn
		orderItemView.IsGift = orderItem.IsGift
		orderItemView.Quantity = orderItem.Quantity

		list = append(list, orderItemView)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get Logs
// @router /logs
func (c *OrderController) GetLogs() {
	var orderId string
	var sortby []string
	var order []string

	// orderId
	if v := c.GetString("order_id"); v != "" {
		orderId = v
	}
	// sortby: col1,col2
	if v := c.GetString("sortby"); v != "" {
		sortby = strings.Split(v, ",")
	}
	// order: desc,asc
	if v := c.GetString("order"); v != "" {
		order = strings.Split(v, ",")
	}

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["OrderId"] = orderId

	cnt, err := models.GetOrderLogCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllOrderLog(query, nil, sortby, order, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}
	var list []interface{}
	for _, orderLog := range l {
		orderLog := orderLog.(models.OrderLog)
		orderLogView := &model_views.OrderLog{}

		orderLogView.Id = orderLog.Id
		orderLogView.OrderId = orderLog.OrderId.Id
		orderLogView.CreationDate = orderLog.CreationDate
		orderLogView.Content = orderLog.Content
		orderLogView.Type = orderLog.Type
		orderLogView.TypeName = orderLogHelper.GetOrderLogTypeName(orderLog.Type)

		list = append(list, orderLogView)
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title Get Order Items
// @router /items [get]
func (c *OrderController) GetOrderItems() {
	var orderId string
	if v := c.GetString("order_id"); v != "" {
		orderId = v
	}

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["OrderId"] = orderId

	cnt, err := models.GetOrderItemCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllOrderItem(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var list []interface{}
	for _, v := range l {
		orderItem := v.(models.OrderItem)
		orderItemView := c.setOrderItemByOrderItemModel(orderItem)

		list = append(list, orderItemView)
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title GetAllOrder
// @Description Get all order's list by some filed
// @Param	query	    query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	sortby	    query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order	    query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ...
// @Param	pageNumber	query	string	false	"Start position of result set. Must be an integer"
// @Param	pageSize	query	int	    false	"Limit the size of result set. Must be an integer"
// @Success 200 {object} model_views.Order
// @Failure 500
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

	if query["Status"] == "noRefund" {
		l, err := models.GetNoRefundOrder(offset, pageSize)
		if err != nil {
			c.ServerError(err)
			return
		}

		var pageList []interface{}
		for _, v := range l {
			orderView := c.setOrderViewByOrderModel(v)
			pageList = append(pageList, orderView)
		}

		query = make(map[string]string)
		query["DeleteFlag"] = "0"
		cnt, err := models.GetOrderNoRefundCount()
		if err != nil {
			c.ServerError(err)
			return
		}

		pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
		if err != nil {
			c.ServerError(err)
			return
		}

		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, *pages)
	} else {
		/*
		 * 处理 query
		 */
		if query["Type"] != "" {
			query["Type"] = strconv.Itoa(orderHelper.GetOrderTypeByName(query["Type"]))
		}
		if query["Status"] != "" {
			query["Status"] = strconv.Itoa(orderHelper.GetOrderStatusByAlias(query["Status"]))
		}
		if query["Member"] != "" {
			member, _ := models.GetMemberByUsername(query["Member"])
			if member != nil {
				query["MemberId"] = strconv.Itoa(member.Id)
			}
			delete(query, "Member")
		}

		query["DeleteFlag"] = "0"
		l, err := models.GetAllOrder(query, nil, sortby, order, offset, pageSize)
		if err != nil {
			c.ServerError(err)
			return
		}

		var pageList []interface{}
		for _, v := range l {
			order := v.(models.Order)
			orderView := c.setOrderViewByOrderModel(order)
			pageList = append(pageList, orderView)
		}

		cnt, err := models.GetOrderCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
		if err != nil {
			c.ServerError(err)
			return
		}

		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, *pages)
	}
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

	if order.CouponCodeId > 0 {
		coupon, err := models.GetCouponById(int(order.CouponCodeId))
		if err != nil {
			c.ServerError(err)
			return
		}
		orderView.CouponCodeId = order.CouponCodeId
		orderView.CouponDiscount = order.CouponDiscount
		orderView.CouponName = coupon.Name
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

func (c *OrderController) addOrderLog(orderId int, logType string, logContent string) {
	/**
	 * 添加订单记录
	 */
	var orderLog models.OrderLog
	orderLog.OrderId = &models.Order{Id: orderId}
	orderLog.CreateBy = c.Admin.Username
	orderLog.Type = orderLogHelper.GetOrderLogTypeByAlias(logType)
	orderLog.Content = logContent

	_, err := models.AddOrderLog(&orderLog)
	if err != nil {
		c.ServerError(err)
		return
	}
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

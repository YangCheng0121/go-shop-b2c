package model_views

type CheckoutOrder struct {
	Amount                float64    `json:"amount" description:"订单金额"`
	CartItems             []CartItem `json:"cart_items" description:"购物项"`
	CouponDiscount        float64    `json:"coupon_discount" description:"优惠券折扣"`
	Price                 float64    `json:"price" description:"商品价格"`
	Fee                   float64    `json:"fee" description:"支付手续费"`
	Freight               float64    `json:"freight" description:"运费"`
	RewardPoint           int64      `json:"reward_point" description:"赠送积分"`
	Memo                  string     `json:"memo" description:"附言"`
	PaymentMethodId       int64      `json:"payment_method_id" description:"支付方式"`
	PaymentMethodName     string     `json:"payment_method_name" description:"支付方式名称"`
	PaymentMethodType     int        `json:"payment_method_type" description:"支付方式类型"`
	PaymentMethodTypeName string     `json:"payment_method_type_name" description:"支付方式类型名称"`
	PromotionName         string     `json:"promotion_name" description:"促销名称"`
	PromotionDiscount     float64    `json:"promotion_discount" description:"促销折扣"`
	ShippingMethodId      int64      `json:"shipping_method_id" description:"配送方式"`
	CouponCode            CouponCode `json:"coupon_code" description:"优惠券"`
	Receiver              *Receiver  `json:"receiver" description:"收货地址"`
	CartKey               string     `json:"cart_key" description:"购物车KEY"`
}

package model_views

import (
	"time"
)

type Order struct {
	Id                    int        `json:"id" description:"主键_id"`
	Member                string     `json:"member" description:"会员"`
	Sn                    string     `json:"sn" description:"订单编号"`
	Status                int        `json:"status" description:"订单状态"`
	StatusName            string     `json:"status_name" description:"订单状态名称"`
	Amount                float64    `json:"amount" description:"订单金额"`
	AmountPaid            float64    `json:"amount_paid" description:"已付金额"`
	CouponDiscount        float64    `json:"coupon_discount" description:"优惠券折扣"`
	OffsetAmount          float64    `json:"offset_amount" description:"调整金额"`
	Price                 float64    `json:"price" description:"商品价格"`
	Fee                   float64    `json:"fee" description:"支付手续费"`
	Freight               float64    `json:"freight" description:"运费"`
	RewardPoint           int64      `json:"reward_point" description:"赠送积分"`
	Consignee             string     `json:"consignee" description:"收货人"`
	AreaName              string     `json:"area_name" description:"地区名称"`
	Address               string     `json:"address" description:"地址"`
	ZipCode               string     `json:"zip_code" description:"邮编"`
	Phone                 string     `json:"phone" description:"电话"`
	ExchangePoint         int64      `json:"exchange_point" description:"兑换积分"`
	IsAllocatedStock      int8       `json:"is_allocated_stock" description:"是否已分配库存"`
	IsExchangePoint       int8       `json:"is_exchange_point" description:"是否已兑换积分"`
	IsUseCouponCode       int8       `json:"is_use_coupon_code" description:"是否已使用优惠码"`
	IsNotify              int8       `json:"is_notify" description:"是否通知"`
	InvoiceContent        string     `json:"invoice_content" description:"发票内容"`
	InvoiceTitle          string     `json:"invoice_title" description:"发票标题"`
	Tax                   float64    `json:"tax" description:"税金"`
	Memo                  string     `json:"memo" description:"附言"`
	PaymentMethodId       int64      `json:"payment_method_id" description:"支付方式"`
	PaymentMethodName     string     `json:"payment_method_name" description:"支付方式名称"`
	PaymentMethodType     int        `json:"payment_method_type" description:"支付方式类型"`
	PaymentMethodTypeName string     `json:"payment_method_type_name" description:"支付方式类型名称"`
	PromotionName         string     `json:"promotion_name" description:"促销名称"`
	PromotionDiscount     float64    `json:"promotion_discount" description:"促销折扣"`
	Expire                *time.Time `json:"expire" description:"到期时间"`
	LockKey               string     `json:"lock_key" description:"锁定KEY"`
	LockExpire            time.Time  `json:"lock_expire" description:"锁定到期时间"`
	Weight                int        `json:"weight" description:"重量"`
	Source                int        `json:"source" description:"订单来源"`
	TypeName              string     `json:"type_name" description:"类型名称"`
	Type                  int        `json:"type" description:"类型"`
	Quantity              int        `json:"quantity" description:"商品数量"`
	RefundAmount          float64    `json:"refund_amount" description:"退款金额"`
	ReturnedQuantity      int        `json:"returned_quantity" description:"退款商品数量"`
	ShippedQuantity       int        `json:"shipped_quantity" description:"已发货数量"`
	ShippingMethodName    string     `json:"shipping_method_name" description:"配送方式名称"`
	ShippingDate          time.Time  `json:"shipping_date" description:"配送时间"`
	ShippingMethodId      int64      `json:"shipping_method_id" description:"配送方式"`
	DeliveryCorpId        int64      `json:"delivery_corp_id" description:"物流公司"`
	DeliveryCorpName      string     `json:"delivery_corp_name" description:"物流公司名称"`
	AreaId                int64      `json:"area_id" description:"地区"`
	MemberId              int64      `json:"member_id" description:"会员"`
	MemberRank            string     `json:"member_rank" description:"会员等级"`
	CouponCodeId          int64      `json:"coupon_code_id" description:"优惠码"`
	CouponName            string     `json:"coupon_name" description:"优惠"`
	TrackingNo            string     `json:"tracking_no" description:"运单号"`
	CompleteDate          time.Time  `json:"complete_date" description:"完成日期"`
	CreationDate          time.Time  `json:"creation_date" description:"创建日期"`
}

type WebOrder struct {
	Order      Order       `json:"order" description:"订单"`
	OrderItems []OrderItem `json:"order_items" description:"订单项"`
}

type OrderCount struct {
	PendingPayment int `json:"pending_payment" description:"支付数"`
	Shipped        int `json:"shipped" description:"发货数"`
}

type OrderCoupon struct {
	Available   []CouponCode `json:"available" description:"可用优惠券"`
	UnAvailable []CouponCode `json:"un_available" description:"不可用优惠券"`
}

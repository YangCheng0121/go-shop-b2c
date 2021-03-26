package models

type OrderCoupon struct {
	Orders  *Order  `orm:"column(orders);rel(fk)" description:"订单"`
	Coupons *Coupon `orm:"column(coupons);rel(fk)" description:"优惠券"`
}

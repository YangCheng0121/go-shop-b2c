package model_views

import "time"

type CouponCode struct {
	Id       int        `json:"id" description:"主键_id"`
	MemberId *int       `json:"member_id" description:"会员"`
	Code     string     `json:"code" description:"号码"`
	Coupon   *Coupon    `json:"coupon" description:"优惠券"`
	IsUsed   int8       `json:"is_used" description:"是否已使用"`
	UsedDate *time.Time `json:"used_date" description:"使用日期"`
}

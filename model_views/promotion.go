package model_views

import "time"

type Promotion struct {
	Id              int        `json:"id" description:"主键_id"`
	Name            string     `json:"name" description:"名称"`
	Title           string     `json:"title" description:"标题"`
	BeginDate       *time.Time `json:"begin_date" description:"起始日期"`
	EndDate         *time.Time `json:"end_date" description:"结束日期"`
	MinimumQuantity *int       `json:"minimum_quantity" description:"最小商品数量"`
	MaximumQuantity *int       `json:"maximum_quantity" description:"最大商品数量"`
	MinimumPrice    *float64   `json:"minimum_price" description:"最小商品价格"`
	MaximumPrice    *float64   `json:"maximum_price" description:"最大商品价格"`
	PriceExpression string     `json:"price_expression" description:"价格运算表达式"`
	PointExpression string     `json:"point_expression" description:"积分运算表达式"`
	IsFreeShipping  int8       `json:"is_free_shipping" description:"是否免运费"`
	IsCouponAllowed int8       `json:"is_coupon_allowed" description:"是否允许使用优惠券"`
	Introduction    string     `json:"introduction" description:"介绍"`
	Orders          int        `json:"orders" description:"排序"`
	MemberRanks     []int      `json:"member_ranks" description:"允许参加会员等级"`
	Coupons         []int      `json:"coupons" description:"赠送优惠券"`
	Gifts           []Gift     `json:"gifts" description:"赠品"`
}

type Gift struct {
	Id        int    `json:"id" description:"ID"`
	Name      string `json:"name" description:"赠品名称"`
	BrandId   int    `json:"brand_id" description:"品牌"`
	BrandName string `json:"brand_name" description:"品牌名称"`
}

package model_views

import "time"

type Coupon struct {
	Id              int        `json:"id" description:"主键_id"`
	Name            string     `json:"name" description:"名称"`
	Condition       string     `json:"condition" description:"条件"`
	Prefix          string     `json:"prefix" description:"前缀"`
	Introduction    string     `json:"introduction" description:"介绍"`
	BeginDate       *time.Time `json:"begin_date" description:"使用起始日期"`
	EndDate         *time.Time `json:"end_date" description:"使用结束日期"`
	IsEnabled       int8       `json:"is_enabled" description:"是否启用"`
	IsExchange      int8       `json:"is_exchange" description:"是否允许积分兑换"`
	MaximumPrice    float64    `json:"maximum_price" description:"最大商品价格"`
	MaximumQuantity int        `json:"maximum_quantity" description:"最大商品数量"`
	MinimumPrice    float64    `json:"minimum_price" description:"最小商品价格"`
	MinimumQuantity int        `json:"minimum_quantity" description:"最小商品数量"`
	Point           int64      `json:"point" description:"积分兑换数"`
	PriceExpression string     `json:"price_expression" description:"价格运算表达式"`
	Value           float64    `json:"value" description:"优惠金额"`
	Quantity        int        `json:"quantity" description:"优惠数量"`
}

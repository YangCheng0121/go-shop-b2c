package model_views

type ShippingMethod struct {
	Id                     int     `json:"id"`
	Name                   string  `json:"name" description:"名称"`
	FirstWeight            int     `json:"first_weight" description:"首重量"`
	ContinueWeight         int     `json:"continue_weight" description:"续重量"`
	FirstPrice             float64 `json:"first_price" description:"首重价格"`
	ContinuePrice          float64 `json:"continue_price" description:"续重价格"`
	Orders                 int     `json:"orders" description:"订单"`
	Icon                   string  `json:"icon" description:"图标"`
	Description            string  `json:"description" description:"description"`
	DefaultDeliveryCorpId  int     `json:"default_delivery_corp_id" description:"默认物流公司"`
	PaymentShippingMethods []int   `json:"payment_shipping_methods" description:"支持支付方式"`
}

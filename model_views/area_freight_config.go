package model_views

type AreaFreightConfig struct {
	Id                 int     `json:"id" description:"主键_ID"`
	FirstPrice         float64 `json:"first_price" description:"首重价格"`
	ContinuePrice      float64 `json:"continue_price" description:"续重价格"`
	ShippingMethodId   int     `json:"shipping_method_id" description:"配送方式"`
	ShippingMethodName string  `json:"shipping_method_name" description:"配方方式名称"`
	AreaId             int     `json:"area_id" description:"地区"`
	AreaName           string  `json:"area_name" description:"地区名称"`
	AreaFullName       string  `json:"area_full_name" description:"地区全称"`
}

package model_views

type ShippingItem struct {
	Id         int    `json:"id" description:"id"`
	Sn         string `json:"sn" description:"商品编号"`
	Name       string `json:"name" description:"商品名称"`
	Quantity   int    `json:"quantity" description:"数量"`
	ShippingId int    `json:"shipping_id" description:"发货单"`
	IsDelivery int8   `json:"is_delivery" description:"是否需要物流"`
}

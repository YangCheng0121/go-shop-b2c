package model_views

type OrderItem struct {
	Id              int     `json:"id" description:"主键_id"`
	Sn              string  `json:"sn" description:"商品编号"`
	Name            string  `json:"name" description:"商品名称"`
	Price           float64 `json:"price" description:"商品价格"`
	Weight          int     `json:"weight" description:"商品重量"`
	Thumbnail       string  `json:"thumbnail" description:"商品缩略图"`
	IsGift          int8    `json:"is_gift" description:"是否为赠品"`
	IsDelivery      int8    `json:"is_delivery" description:"是否需要物流"`
	Quantity        int     `json:"quantity" description:"数量"`
	ShippedQuantity int     `json:"shipped_quantity" description:"已发货数量"`
	ReturnQuantity  int     `json:"return_quantity" description:"已退货数量"`
	ShipQuantity    int     `json:"ship_quantity" description:"发货数"`
	OrderId         int     `json:"order_id" description:"订单"`
	Sku             *Sku    `json:"sku" description:"SKU"`
}

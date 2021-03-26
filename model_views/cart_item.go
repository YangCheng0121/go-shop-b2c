package model_views

type CartItem struct {
	Id         int      `json:"id" description:"主键_id"`
	CartId     int      `json:"cart_id" description:"购物车"`
	Quantity   int      `json:"quantity" description:"数量"`
	Sku        *Sku     `json:"sku" description:"SKU"`
	Product    *Product `json:"product" description:"商品"`
	DeleteFlag int8     `json:"delete_flag" description:"删除标记"`
}

package model_views

type ReturnsItem struct {
	Id        int    `json:"id" description:"id"`
	Sn        string `json:"sn" description:"商品编号"`
	Name      string `json:"name" description:"商品名称"`
	Quantity  int    `json:"quantity" description:"数量"`
	ReturnsId int    `json:"returns_id" description:"退货单-关联returns"`
}

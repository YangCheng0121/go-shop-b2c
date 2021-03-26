package model_views

import "time"

type StockLog struct {
	Id           int       `json:"id" description:"主键_id"`
	InQuantity   int       `json:"in_quantity" description:"入库数量"`
	OutQuantity  int       `json:"out_quantity" description:"出库数量"`
	Type         string    `json:"type" description:"类型"`
	Stock        int       `json:"stock" description:"当前库存"`
	Sku          *Sku      `json:"sku" description:"SKU"`
	Memo         string    `json:"memo" description:"备注"`
	CreationDate time.Time `json:"creation_date" description:"创建日期"`
}

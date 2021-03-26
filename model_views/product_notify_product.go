package model_views

type ProductNotifyProduct struct {
	Id             int    `json:"id" description:"id" json:"主键_id"`
	Sn             string `json:"sn" description:"编号"`
	Name           string `json:"name" description:"名称"`
	FullName       string `json:"full_name" description:"全称"`
	Stock          int    `json:"stock" description:"库存"`
	AllocatedStock int    `json:"allocated_stock" description:"已分配库存"`
	IsMarketable   int8   `json:"is_marketable" description:"是否上架"`
	DeleteFlag     int8   `json:"delete_flag" description:"删除标记"`
}

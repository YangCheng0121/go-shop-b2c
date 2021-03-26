package model_views

type Parameter struct {
	Id         int    `json:"id" description:"主键_id"`
	Name       string `json:"name" description:"名称"`
	Orders     int    `json:"orders" description:"排序"`
	DeleteFlag int8   `json:"delete_flag" description:"删除标记"`
}

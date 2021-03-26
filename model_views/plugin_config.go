package model_views

type PluginConfig struct {
	Id         int    `json:"id" description:"主键_id"`
	PluginId   string `json:"plugin_id" description:"插件ID"`
	IsEnabled  int8   `json:"is_enabled" description:"是否启用"`
	Orders     int    `json:"orders" description:"排序"`
	Attributes string `json:"attributes" description:"属性"`
	Type       int    `json:"type" description:"类型"`
	CreateBy   string `json:"create_by" description:"创建人"`
}

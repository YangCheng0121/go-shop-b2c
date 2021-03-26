package model_views

type PaymentMethod struct {
	Id          int    `json:"id" description:"主键_id"`
	Name        string `json:"name" description:"名称"`
	Method      int    `json:"method" description:"方式"`
	MethodName  string `json:"method_name" description:"方式名称"`
	Timeout     int    `json:"timeout" description:"超时时间"`
	Orders      int    `json:"orders" description:"排序"`
	Icon        string `json:"icon" description:"图标"`
	Description string `json:"description" description:"介绍"`
	Content     string `json:"content" description:"内容"`
	Type        int    `json:"type" description:"类型"`
	TypeName    string `json:"type_name" description:"类型名称"`
}

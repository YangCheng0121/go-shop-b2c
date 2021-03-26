package model_views

type ParameterGroup struct {
	Id              int                       `json:"id" description:"主键_id"`
	Name            string                    `json:"name" description:"名称"`
	Parameter       []*Parameter              `json:"parameter" description:"参数名称"`
	ProductCategory *ParameterProductCategory `json:"product_category" description:"绑定分类"`
	Orders          int                       `json:"orders" description:"排序"`
	DeleteFlag      int8                      `json:"delete_flag" description:"删除标记"`
}

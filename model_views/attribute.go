package model_views

type Attribute struct {
	Id              int                       `json:"id" description:"主键_id"`
	Name            string                    `json:"name" description:"名称"`
	PropertyIndex   int                       `json:"property_index" description:"属性序号"`
	ProductCategory *AttributeProductCategory `json:"product_category" description:"绑定分类"`
	Options         []string                  `json:"options" description:"可选项"`
	Orders          int                       `json:"orders" description:"排序"`
	DeleteFlag      int8                      `json:"delete_flag" description:"删除标记"`
}

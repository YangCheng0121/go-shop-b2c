package model_views

type Specification struct {
	Id              int                           `json:"id" description:"主键_id"`
	Name            string                        `json:"name" description:"名称"`
	ProductCategory *SpecificationProductCategory `json:"product_category" description:"绑定分类"`
	Options         []string                      `json:"options" description:"可选项"`
	Type            int                           `json:"type" description:"类型"`
	Orders          int                           `json:"orders" description:"排序"`
	DeleteFlag      int8                          `json:"delete_flag" description:"删除标记"`
}

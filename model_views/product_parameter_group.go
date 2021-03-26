package model_views

type ProductParameterGroup struct {
	Id                int                `json:"id" description:"主键_id"`
	Group             string             `json:"group" description:"参数组"`
	Names             []ProductParameter `json:"names" description:"参数组_names"`
	ProductCategoryId int                `json:"product_category_id" description:"绑定分类"`
	Orders            int                `json:"orders" description:"排序"`
	DeleteFlag        int8               `json:"delete_flag" description:"删除标记"`
}

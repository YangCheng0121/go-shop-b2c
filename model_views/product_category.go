package model_views

type ProductCategory struct {
	Id           int      `json:"id" description:"主键_id"`
	Name         string   `json:"name" description:"名称"`
	Grade        int      `json:"grade" description:"层级"`
	ParentId     *int     `json:"parent_id" description:"上级分类ID"`
	ParentName   string   `json:"parent_name" description:"上级分类名称"`
	Orders       int      `json:"orders" description:"排序"`
	Promotions   []string `json:"promotions" description:"促销"`
	TreePath     string   `json:"tree_path" description:"树路径"`
	Image        string   `json:"image" description:"图片"`
	IsMarketable int8     `json:"is_marketable" description:"是否上架"`
	IsTop        int8     `json:"is_top" description:"是否置顶"`
	IsShow       int8     `json:"is_show" description:"是否显示"`
	DeleteFlag   int8     `json:"delete_flag" description:"删除标记"`
}

type ProductCategoryProducts struct {
	ProductCategory
	Products []Product `json:"products"`
}

type ProductCategoryChildren struct {
	ProductCategory
	Children []ProductCategory `json:"children"`
}

package model_views

type Area struct {
	Id       int    `json:"id" description:"主键_id"`
	FullName string `json:"full_name" description:"全称"`
	Name     string `json:"name" description:"名称"`
	TreePath string `json:"tree_path" description:"树路径"`
	ParentId int64  `json:"parent_id" description:"上级地区"`
	Orders   int    `json:"orders" description:"排序"`
}

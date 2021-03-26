package model_views

type AdPosition struct {
	Id          int    `json:"id" description:"主键_id"`
	Description string `json:"description" description:"描述"`
	Height      int    `json:"height" description:"高度"`
	Name        string `json:"name" description:"名称"`
	Template    string `json:"template" description:"模板"`
	Width       int    `json:"width" description:"宽度"`
}

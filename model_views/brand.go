package model_views

type Brand struct {
	Id           int    `json:"id" description:"主键_id"`
	Name         string `json:"name" description:"名称"`
	Type         int    `json:"type" description:"类型"`
	Logo         string `json:"logo" description:"logo"`
	Url          string `json:"url" description:"网址"`
	Orders       int    `json:"orders" description:"排序"`
	Introduction string `json:"introduction" description介:"介绍"`
}

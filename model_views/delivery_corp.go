package model_views

type DeliveryCorp struct {
	Id     int    `json:"id" description:"主键_id"`
	Name   string `json:"name" description:"名称"`
	Url    string `json:"url" description:"网址"`
	Code   string `json:"code" description:"代码"`
	Orders int    `json:"orders" description:"排序"`
}

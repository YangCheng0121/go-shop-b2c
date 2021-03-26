package model_views

import "time"

type Consultation struct {
	Id              int            `json:"id" description:"主键_id"`
	ForConsultation []Consultation `json:"for_consultation" description:"咨询"`
	Reply           string         `json:"reply" description:"回复"`
	ProductId       int            `json:"product_id" description:"商品"`
	ProductName     string         `json:"product_name" description:"商品名称"`
	Content         string         `json:"content" description:"内容"`
	MemberId        *int           `json:"member_id" description:"会员"`
	Username        string         `json:"username" description:"用户名"`
	IsShow          int8           `json:"is_show" description:"是否显示"`
	Ip              string         `json:"ip" description:"IP"`
	CreationDate    time.Time      `json:"creation_date" description:"创建日期"`
}

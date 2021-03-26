package model_views

import "time"

type Review struct {
	Id           int       `json:"id" description:"id"`
	Score        int       `json:"score" description:"评分"`
	Content      string    `json:"content" description:"内容"`
	IsShow       int8      `json:"is_show" description:"是否显示"`
	Ip           string    `json:"ip" description:"IP"`
	MemberId     int       `json:"member_id" description:"会员"`
	Username     string    `json:"username" description:"用户名"`
	ProductId    int       `json:"product_id" description:"商品"`
	ProductName  string    `json:"product_name" description:"商品名称"`
	CreationDate time.Time `json:"creation_date" description:"创建日期"`
}

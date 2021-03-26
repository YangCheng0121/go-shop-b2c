package model_views

import "time"

type OrderLog struct {
	Id           int       `json:"id" description:"主键_id"`
	Type         int       `json:"type" description:"类型"`
	TypeName     string    `json:"type_name" description:"类型名称"`
	Operator     string    `json:"operator" description:"操作员"`
	Content      string    `json:"content" description:"内容"`
	OrderId      int       `json:"order_id" description:"订单"`
	CreationDate time.Time `json:"creation_date" description:"创建日期"`
}

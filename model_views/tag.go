package model_views

import "time"

type Tag struct {
	Id           int       `json:"id" description:"id"`
	Name         string    `json:"name" description:"名称"`
	Type         int       `json:"type" description:"类型"`
	Icon         string    `json:"icon" description:"图标"`
	Orders       int       `json:"orders" description:"排序"`
	Memo         string    `json:"memo" description:"备注"`
	DeleteFlag   int8      `json:"delete_flag" description:"删除标记"`
	CreationDate time.Time `json:"creation_date"description:"创建日期"`
}

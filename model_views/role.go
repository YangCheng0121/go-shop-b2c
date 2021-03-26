package model_views

import "time"

type Role struct {
	Id           int          `json:"id" description:"主键_id"`
	Name         string       `json:"name" description:"名称"`
	Value        string       `json:"value" description:"值"`
	Description  string       `json:"description" description:"简介"`
	Orders       int          `json:"orders" description:"排序"`
	IsSystem     int8         `json:"is_system" description:"是否系统角色"`
	CreationDate time.Time    `json:"creation_date" description:"创建日期"`
	Permissions  []Permission `json:"permissions" description:"权限"`
}

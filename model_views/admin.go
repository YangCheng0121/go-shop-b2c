package model_views

import "time"

type Admin struct {
	Id           string    `json:"id" description:"主键_id"`
	Name         string    `json:"name" description:"姓名"`
	Username     string    `json:"username" description:"用户名"`
	Department   string    `json:"department" description:"部门"`
	Email        string    `json:"email" description:"E-mail"`
	IsEnabled    int8      `json:"is_enabled" description:"是否启用"`
	IsLocked     int8      `json:"is_locked" description:"是否锁定"`
	Roles        int       `json:"roles" description:"角色"`
	LoginIp      string    `json:"login_ip" description:"最后登录IP"`
	CreationDate time.Time `json:"creation_date" description:"创建日期"`
}

package model_views

type ProductNotifyMember struct {
	Id         int    `json:"id" description:"主键_id"`
	Username   string `json:"username" description:"用户名"`
	Password   string `json:"password" description:"密码"`
	Name       string `json:"name" description:"姓名"`
	DeleteFlag int8   `json:"delete_flag" description:"删除标记"`
}

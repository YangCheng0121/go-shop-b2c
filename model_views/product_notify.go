package model_views

import "time"

type ProductNotify struct {
	Id              int                   `json:"id" description:"主键_id"`
	Email           string                `json:"email" description:"E-mail"`
	HasSent         int8                  `json:"has_sent" description:"是否已发送"`
	MemberId        int                   `json:"member_id" description:"会员_id"`
	MemberName      string                `json:"member_name" description:"会员名称"`
	Product         *ProductNotifyProduct `json:"product" description:"商品_id"`
	CreationDate    time.Time             `json:"creation_date" description:"创建日期"`
	LastUpdatedDate time.Time             `json:"last_updated_date" description:"最后修改日期"`
	DeleteFlag      int8                  `json:"delete_flag" description:"删除标记"`
}

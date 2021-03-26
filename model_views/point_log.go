package model_views

import "time"

type PointLog struct {
	Id           int       `json:"id" description:"主键_id"`
	Balance      int64     `json:"balance" description:"当前积分"`
	Credit       int64     `json:"credit" description:"获取积分"`
	Debit        int64     `json:"debit" description:"扣除积分"`
	Memo         string    `json:"memo" description:"备注"`
	Type         int       `json:"type" description:"类型"`
	TypeName     string    `json:"type_name" description:"类型名称"`
	MemberId     int       `json:"member_id" description:"会员"`
	Username     string    `json:"member" description:"用户名"`
	Operator     string    `json:"operator" description:"操作员"`
	CreationDate time.Time `json:"creation_date" description:"创建日期"`
}

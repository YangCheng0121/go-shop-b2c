package model_views

import "time"

type DepositLog struct {
	Id           int       `json:"id" description:"主键_id"`
	Type         int       `json:"type" description:"类型"`
	TypeName     string    `json:"type_name" description:"类型名称"`
	MemberId     int       `json:"member_id" description:"会员"`
	Username     string    `json:"member" description:"用户名"`
	Operator     string    `json:"operator" description:"操作员"`
	Payment      int       `json:"payment" description:"收款单"`
	Credit       float64   `json:"credit" description:"收入金额"`
	Detinyint    float64   `json:"detinyint" description:"支出金额"`
	Balance      float64   `json:"balance" description:"当前余额"`
	OrderId      int64     `json:"order_id" description:"订单"`
	Memo         string    `json:"memo" description:"备注"`
	CreationDate time.Time `json:"creation_date" description:"创建日期"`
}

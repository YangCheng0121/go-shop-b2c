package model_views

import "time"

type Payment struct {
	Id              int       `json:"id" description:"主键_id"`
	Sn              string    `json:"sn" description:"编号"`
	Method          int       `json:"method" description:"方式"`
	MethodName      string    `json:"method_name" description:"方式名称"`
	PaymentMethod   string    `json:"payment_method" description:"支付方式"`
	Bank            string    `json:"bank" description:"收款银行"`
	Account         string    `json:"account" description:"收款账号"`
	Fee             float64   `json:"fee" description:"支付手续费"`
	Amount          float64   `json:"amount" description:"付款金额"`
	Payer           string    `json:"payer" description:"付款人"`
	Operator        string    `json:"operator" description:"操作员"`
	PaymentDate     time.Time `json:"payment_date" description:"付款日期"`
	Memo            string    `json:"memo" description:"备注"`
	PaymentPluginId string    `json:"payment_plugin_id" description:"支付插件ID"`
	Expire          time.Time `json:"expire" description:"到期时间"`
	MemberId        int64     `json:"member_id" description:"会员"`
	OrderId         int64     `json:"order_id" description:"订单"`
	OrderSn         string    `json:"order_sn" description:"订单SN"`
	CreationDate    time.Time `json:"creation_date" description:"创建日期"`
}

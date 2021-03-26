package model_views

import "time"

type Refunds struct {
	Id            int       `json:"id" description:"id"`
	Sn            string    `json:"sn" description:"编号"`
	IsReview      int8      `json:"is_review" description:"是否审核通过"`
	Method        int       `json:"method" description:"方式"`
	MethodName    string    `json:"method_name" description:"方式名称"`
	PaymentMethod string    `json:"payment_method" description:"支付方式"`
	Bank          string    `json:"bank" description:"退款银行"`
	Account       string    `json:"account" description:"退款账号"`
	Amount        float64   `json:"amount" description:"退款金额"`
	Payee         string    `json:"payee" description:"收款人"`
	Operator      string    `json:"operator" description:"操作员"`
	Memo          string    `json:"memo" description:"备注"`
	OrderId       int       `json:"order_id" description:"订单"`
	OrderSn       string    `json:"order_sn" description:"订单SN"`
	CreationDate  time.Time `json:"creation_date" description:"创建日期"`
}

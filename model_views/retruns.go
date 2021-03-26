package model_views

import "time"

type Returns struct {
	Id             int           `json:"id" description:"id"`
	Sn             string        `json:"sn" description:"编号"`
	ShippingMethod string        `json:"shipping_method" description:"配送方式"`
	DeliveryCorp   string        `json:"delivery_corp" description:"物流公司"`
	TrackingNo     string        `json:"tracking_no" description:"运单号"`
	Freight        float64       `json:"freight" description:"物流费用"`
	Shipper        string        `json:"shipper" description:"发货人"`
	Area           string        `json:"area" description:"地区"`
	Address        string        `json:"address" description:"地址"`
	ZipCode        string        `json:"zip_code" description:"邮编"`
	Phone          string        `json:"phone" description:"电话"`
	Operator       string        `json:"operator" description:"操作员"`
	Memo           string        `json:"memo" description:"备注"`
	OrderId        int           `json:"order_id" description:"订单"`
	OrderSn        string        `json:"order_sn" description:"订单编号"`
	Items          []ReturnsItem `json:"items" description:"退货项"`
	CreationDate   time.Time     `json:"creation_date" description:"创建日期"`
}

package model_views

import "time"

type Shipping struct {
	Id               int            `json:"id" description:"id"`
	Sn               string         `json:"sn" description:"编号"`
	ShippingMethod   string         `json:"shipping_method" description:"配送方式"`
	DeliveryCorp     string         `json:"delivery_corp" description:"物流公司"`
	DeliveryCorpUrl  string         `json:"delivery_corp_url" description:"物流公司网址"`
	DeliveryCorpCode string         `json:"delivery_corp_code" description:"物流公司代码"`
	TrackingNo       string         `json:"tracking_no" description:"运单号"`
	Freight          float64        `json:"freight" description:"物流费用"`
	Consignee        string         `json:"consignee" description:"收货人"`
	Area             string         `json:"area" description:"地区"`
	Address          string         `json:"address" description:"地址"`
	ZipCode          string         `json:"zip_code" description:"邮编"`
	Phone            string         `json:"phone" description:"电话"`
	Operator         string         `json:"operator" description:"操作员"`
	Memo             string         `json:"memo" description:"备注"`
	OrderId          int64          `json:"order_id" description:"订单"`
	OrderSn          string         `json:"order_sn" description:"订单编号"`
	Items            []ShippingItem `json:"items" description:"发货项"`
	CreationDate     time.Time      `json:"creation_date" description:"创建日期"`
	CreateBy         string         `json:"create_by" description:"创建人"`
}

package model_views

type Receiver struct {
	Id        int    `json:"id" description:"id"`
	Consignee string `json:"consignee" description:"收货人"`
	AreaName  string `json:"area_name" description:"地区名称"`
	Address   string `json:"address" description:"地址"`
	ZipCode   string `json:"zip_code" description:"邮编"`
	Phone     string `json:"phone" description:"电话"`
	IsDefault int8   `json:"is_default" description:"是否默认"`
	AreaId    int64  `json:"area_id" description:"地区"`
	MemberId  int64  `json:"member_id" description:"会员"`
}

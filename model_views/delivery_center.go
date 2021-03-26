package model_views

type DeliveryCenter struct {
	Id        int    `json:"id" description:"主键_id"`
	Name      string `json:"name" description:"名称"`
	Contact   string `json:"contact" description:"联系人"`
	Mobile    string `json:"mobile" description:"手机"`
	Phone     string `json:"phone" description:"电话"`
	AreaId    int64  `json:"area_id" description:"地区"`
	AreaName  string `json:"area_name" description:"地区名称"`
	ZipCode   string `json:"zip_code" description:"邮编"`
	Address   string `json:"address" description:"地址"`
	IsDefault int8   `json:"is_default" description:"是否默认"`
	Memo      string `json:"memo" description:"备注"`
}

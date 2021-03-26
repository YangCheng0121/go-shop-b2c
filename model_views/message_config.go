package model_views

type MessageConfig struct {
	Id            int    `json:"id" description:"主键_ID"`
	IsMailEnabled int8   `json:"is_mail_enabled" description:"是否启用邮件"`
	IsSmsEnabled  int8   `json:"is_sms_enabled" description:"是否启用短信"`
	Type          int    `json:"type" description:"类型"`
	TypeName      string `json:"type_name" description:"类型名称"`
}

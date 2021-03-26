package model_views

import "time"

type Member struct {
	Id                int       `json:"id" description:"主键_id"`
	Username          string    `json:"username" description:"用户名"`
	Name              string    `json:"name" description:"姓名"`
	Avatar            string    `json:"avatar" description:"头像"`
	Gender            int       `json:"gender" description:"性别"`
	Mobile            string    `json:"mobile" description:"手机"`
	Phone             string    `json:"phone" description:"电话"`
	Birth             time.Time `json:"birth" description:"出生日期"`
	ZipCode           string    `json:"zip_code" description:"邮编"`
	AreaId            int64     `json:"area_id" description:"地区"`
	Address           string    `json:"address" description:"地址"`
	Email             string    `json:"email" description:"E-mail"`
	Amount            float64   `json:"amount" description:"消费金额"`
	Balance           float64   `json:"balance" description:"余额"`
	Point             int64     `json:"point" description:"积分"`
	MemberRankId      int64     `json:"member_rank_id" description:"会员等级"`
	MemberRank        string    `json:"member_rank" description:"会员等级名称"`
	RegisterIp        string    `json:"register_ip" description:"注册IP"`
	AttributeValue0   string    `json:"attribute_value_0" description:"会员注册项值0"`
	AttributeValue1   string    `json:"attribute_value_1" description:"会员注册项值1"`
	AttributeValue2   string    `json:"attribute_value_2" description:"会员注册项值2"`
	AttributeValue3   string    `json:"attribute_value_3" description:"会员注册项值3"`
	AttributeValue4   string    `json:"attribute_value_4" description:"会员注册项值4"`
	AttributeValue5   string    `json:"attribute_value_5" description:"会员注册项值5"`
	AttributeValue6   string    `json:"attribute_value_6" description:"会员注册项值6"`
	AttributeValue7   string    `json:"attribute_value_7" description:"会员注册项值7"`
	AttributeValue8   string    `json:"attribute_value_8" description:"会员注册项值8"`
	AttributeValue9   string    `json:"attribute_value_9" description:"会员注册项值9"`
	IsEnabled         int8      `json:"is_enabled" description:"是否启用"`
	IsLocked          int8      `json:"is_locked" description:"是否锁定"`
	LockedDate        time.Time `json:"locked_date" description:"锁定日期"`
	LoginDate         time.Time `json:"login_date" description:"最后登录日期"`
	LoginFailureCount int       `json:"login_failure_count" description:"连续登录失败次数"`
	LoginIp           string    `json:"login_ip" description:"最后登录IP"`
	Password1         string    `json:"password1" description:"密码"`
	Password2         string    `json:"password2" description:"确认密码"`
	SafeKeyExpire     time.Time `json:"safe_key_expire" description:"安全密匙有效期"`
	SafeKeyValue      string    `json:"safe_key_value" description:"安全密匙值"`
	CreationDate      time.Time `json:"creation_date" description:"创建日期"`
}

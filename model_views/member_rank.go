package model_views

type MemberRank struct {
	Id        int     `json:"id" description:"主键_id"`
	Name      string  `json:"name" description:"名称"`
	Amount    float64 `json:"amount" description:"消费金额"`
	IsDefault int8    `json:"is_default" description:"是否默认"`
	IsSpecial int8    `json:"is_special" description:"是否特殊"`
	Scale     float64 `json:"scale" description:"优惠比例"`
}

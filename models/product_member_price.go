package models

type ProductMemberPrice struct {
	Product        *Product    `orm:"column(product);rel(fk)"`
	MemberPrice    float64     `orm:"column(member_price);null;digits(19);decimals(2)"`
	MemberPriceKey *MemberRank `orm:"column(member_price_key);rel(fk)"`
}

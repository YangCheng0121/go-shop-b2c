package models

type MemberAttributeOption struct {
	MemberAttribute *MemberAttribute `orm:"column(member_attribute);rel(fk)"`
	Options         string           `orm:"column(options);size(255);null"`
}

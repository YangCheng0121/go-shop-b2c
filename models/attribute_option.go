package models

import "github.com/astaxie/beego/orm"

type AttributeOption struct {
	Attribute int    `orm:"column(attribute);"`
	Options   string `orm:"column(options);size(255);null" description:"可选项"`
}

// AddAttributeOption insert a new AttributeOption into database and returns
func AddAttributeOption(m *AttributeOption) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO attribute_option (attribute, options) VALUES(?,?)"
	_, err = o.Raw(sql, m.Attribute, m.Options).Exec()
	return
}

// GetAllOptionsByAttribute retrieves all Options matches certain condition. Returns empty list if
// no records exist
func GetAllOptionsByAttribute(attribute int) (ml []AttributeOption, err error) {
	o := orm.NewOrm()
	sql := "SELECT attribute,options FROM attribute_option WHERE attribute = ?"
	if num, err := o.Raw(sql, attribute).QueryRows(&ml); err == nil && num > 0 {
		return ml, nil
	}
	return nil, err
}

// DeleteAttributeOptionByAttributeAndOption deletes AttributeOption by attribute and options,returns error if
// the record to be deleted doesn't exist
func DeleteAttributeOption(m *AttributeOption) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM attribute_option WHERE attribute = ? AND options = ?"
	_, err = o.Raw(sql, m.Attribute, m.Options).Exec()
	return
}

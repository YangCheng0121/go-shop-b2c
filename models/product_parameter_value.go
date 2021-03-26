package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
)

type ProductParameterValue struct {
	Product           int    `orm:"column(product);"`
	ParameterValue    string `orm:"column(parameter_value);size(255);null"`
	ParameterValueKey int    `orm:"column(parameter_value_key);"`
}

// AddProductParameterValue insert a new ProductParameterValue into database
func AddProductParameterValue(product int, parameterValue string, parameterValueKey int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `product_parameter_value` (`product`, `parameter_value`, `parameter_value_key`) VALUES(?, ?,?)"
	_, err = o.Raw(sql, product, parameterValue, parameterValueKey).Exec()
	return
}

// GetProductParameterValueByProduct retrieves ProductParameterValue by Product. Returns error if
// record doesn't exist
func GetProductParameterValueByProduct(product int) (v []ProductParameterValue, err error) {
	o := orm.NewOrm()
	sql := "SELECT `product`, `parameter_value`, `parameter_value_key` FROM `product_parameter_value` WHERE `product` = ?"
	if _, err := o.Raw(sql, product).QueryRows(&v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetProductParameterValueByParameterValueKey retrieves ProductParameterValue by ParameterValueKey. Returns error if
// record doesn't exist
func GetProductParameterValueByParameterValueKey(parameterValueKey int) (v *ProductParameterValue, err error) {
	o := orm.NewOrm()
	sql := "SELECT `product`, `parameter_value`, `parameter_value_key` FROM `product_parameter_value` WHERE `parameter_value_key` = ?"
	if err := o.Raw(sql, parameterValueKey).QueryRow(&v); err == nil {
		return v, nil
	}
	return nil, err
}

// UpdateProductParameterValue updates ProductParameterValue, returns error if
// the record to be updated doesn't exist
func UpdateProductParameterValue(parameterValue string, product int, parameterValueKey int) (err error) {
	o := orm.NewOrm()
	sql := "UPDATE `product_parameter_value` SET `parameter_value` = ? WHERE `product` = ? AND `parameter_value_key` = ?"
	if _, err := o.Raw(sql, parameterValue, product, parameterValueKey).Exec(); err == nil {
		return nil
	}
	return err
}

// DeleteProductParameterValue deletes ProductParameterValue by Product AND ParameterValueKey. Returns error if
// the record to be deleted doesn't exist
func DeleteProductParameterValue(product int, parameterValueKey int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `product_parameter_value` WHERE `product` = ? AND `parameter_value_key` = ?"
	if num, err := o.Raw(sql, product, parameterValueKey).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

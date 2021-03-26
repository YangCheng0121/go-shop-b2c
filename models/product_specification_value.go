package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
)

type ProductSpecificationValue struct {
	Products            int `orm:"column(products);"`
	SpecificationValues int `orm:"column(specification_values);"`
}

// AddProductSpecificationValue insert a new ProductSpecificationValue into database
func AddProductSpecificationValue(products int, specificationValues int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `product_specification_value` (`products`, `specification_values`) VALUES(?, ?)"
	_, err = o.Raw(sql, products, specificationValues).Exec()
	return
}

// GetProductSpecificationValueByProducts retrieves ProductSpecificationValue by Products. Returns error if
// record doesn't exist
func GetProductSpecificationValueByProducts(products int) (v []ProductSpecificationValue, err error) {
	o := orm.NewOrm()
	sql := "SELECT `products`, `specification_values` FROM `product_specification_value` WHERE `products` = ?"
	if _, err := o.Raw(sql, products).QueryRows(&v); err == nil {
		return v, nil
	}
	return nil, err
}

// DeleteProductSpecificationValue deletes ProductSpecificationValue by Products and SpecificationValues. Returns error if
// the record to be deleted doesn't exist
func DeleteProductSpecificationValue(products int, specificationValues int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `product_specification_value` WHERE `products` = ? AND `specification_values` = ?"
	if num, err := o.Raw(sql, products, specificationValues).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

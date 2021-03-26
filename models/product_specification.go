package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
)

type ProductSpecification struct {
	Products       int `orm:"column(products);" description:"商品_id"`
	Specifications int `orm:"column(specifications);" description:"属性_id"`
}

// AddProductSpecification insert a new ProductSpecification into database
func AddProductSpecification(products int, specifications int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `product_specification` (`products`, `specifications`) VALUES(?, ?)"
	_, err = o.Raw(sql, products, specifications).Exec()
	return
}

// GetProductSpecificationByProducts retrieves Products by Products. Returns error if
// record doesn't exist
func GetProductSpecificationByProducts(products int) (v []ProductSpecification, err error) {
	o := orm.NewOrm()
	sql := "SELECT `products`, `specifications` FROM `product_specification` WHERE `products` = ?"
	if _, err := o.Raw(sql, products).QueryRows(&v); err == nil {
		return v, nil
	}
	return nil, err
}

// DeleteProductSpecification deletes ProductSpecification by Products and Specifications. Returns error if
// the record to be deleted doesn't exist
func DeleteProductSpecification(products int, specifications int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `product_specification` WHERE `products` = ? AND `specifications` = ?"
	if num, err := o.Raw(sql, products, specifications).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

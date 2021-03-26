package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
)

type ProductTag struct {
	Products int `orm:"column(products)"`
	Tags     int `orm:"column(tags)"`
}

// AddProductTag insert a new ProductTag into database
func AddProductTag(products int, tags int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `product_tag` (`products`,`tags`) VALUES (?, ?)"
	_, err = o.Raw(sql, products, tags).Exec()
	return
}

// GetProductTagByProducts retrieves ProductTag by products. Returns error if
// record doesn't exist
func GetProductTagByProducts(products int) (v []ProductTag, err error) {
	o := orm.NewOrm()
	sql := "SELECT `products`,`tags` FROM `product_tag` WHERE `products` = ?"
	if _, err := o.Raw(sql, products).QueryRows(&v); err == nil {
		return v, nil
	}
	return nil, err
}

// DeleteProductTag deletes ProductTag by Products and Tags. Returns error if
// the record to be deleted doesn't exist
func DeleteProductTag(products int, tags int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `product_tag` WHERE `products` = ? AND `tags` = ?"
	if num, err := o.Raw(sql, products, tags).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

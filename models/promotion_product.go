package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
)

type PromotionProduct struct {
	Promotions int `orm:"column(promotions)"`
	Products   int `orm:"column(products)"`
}

// AddPromotionProduct insert a new PromotionProduct into database
func AddPromotionProduct(promotions int, products int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `promotion_product` (`promotions`, `products`) VALUES(?, ?)"
	_, err = o.Raw(sql, promotions, products).Exec()
	return
}

// GetPromotionProductByProducts retrieves PromotionProduct by Products. Returns error if
// Products doesn't exist
func GetPromotionProductByProducts(products int) (v []PromotionProduct, err error) {
	o := orm.NewOrm()
	sql := "SELECT `promotions`, `products` FROM `promotion_product` WHERE `products` = ?"
	if _, err = o.Raw(sql, products).QueryRows(&v); err == nil {
		return v, nil
	}
	return nil, err
}

// DeletePromotionProduct deletes PromotionProduct by Promotions and Products. Returns error if
// the record to be deleted doesn't exist
func DeletePromotionProduct(promotions int, products int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `promotion_product` WHERE `promotions` = ? AND `products` = ?"
	if num, err := o.Raw(sql, promotions, products).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
)

type PromotionBrand struct {
	Promotions int `orm:"column(promotions);rel(fk)"`
	Brands     int `orm:"column(brands);rel(fk)"`
}

// AddPromotionBrand insert a new PromotionBrand into database
func AddPromotionBrand(promotions int, brands int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `promotion_brand` (`promotions`, `brands`) VALUES(?, ?)"
	_, err = o.Raw(sql, promotions, brands).Exec()
	return
}

// GetPromotionBrandByPromotions retrieves PromotionBrand by Promotions. Returns error if
// Promotions doesn't exist
func GetPromotionBrandByPromotions(brands int) (v []PromotionBrand, err error) {
	o := orm.NewOrm()
	sql := "SELECT `promotions`, `brands` FROM `promotion_brand` WHERE `brands` = ?"
	if num, err := o.Raw(sql, brands).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

// DeletePromotionBrand deletes PromotionBrand by promotions and brands. Returns error if
// the record to be deleted doesn't exist
func DeletePromotionBrand(promotions int, brands int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `promotion_brand` WHERE `promotions` = ? AND `brands` = ?"
	if num, err := o.Raw(sql, promotions, brands).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

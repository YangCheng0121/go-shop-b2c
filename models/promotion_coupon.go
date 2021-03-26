package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
)

type PromotionCoupon struct {
	Promotions int `orm:"column(promotions);rel(fk)"`
	Coupons    int `orm:"column(coupons);rel(fk)"`
}

// AddPromotionCoupon insert a new PromotionCoupon into database
func AddPromotionCoupon(promotions int, coupons int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `promotion_coupon` (`promotions`, `coupons`) VALUES(?, ?)"
	_, err = o.Raw(sql, promotions, coupons).Exec()
	return
}

// GetPromotionCouponByPromotions retrieves PromotionCoupon by Promotions. Returns error if
// Promotions doesn't exist
func GetPromotionCouponByPromotions(promotions int) (v []PromotionCoupon, err error) {
	o := orm.NewOrm()
	sql := "SELECT `promotions`, `coupons` FROM `promotion_coupon` WHERE `promotions` = ?"
	if num, err := o.Raw(sql, promotions).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

// DeletePromotionCoupon deletes PromotionCoupon by promotions and coupons. Returns error if
// the record to be deleted doesn't exist
func DeletePromotionCoupon(promotions int, coupons int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `promotion_coupon` WHERE `promotions` = ? AND `coupons` = ?"
	if num, err := o.Raw(sql, promotions, coupons).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

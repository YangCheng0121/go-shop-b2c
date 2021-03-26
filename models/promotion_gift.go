package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
)

type PromotionGift struct {
	Promotions int `orm:"column(promotions);rel(fk)"`
	Gifts      int `orm:"column(gifts);rel(fk)"`
}

// AddPromotionGift insert a new PromotionGift into database
func AddPromotionGift(promotions int, gifts int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `promotion_gift` (`promotions`, `gifts`) VALUES(?, ?)"
	_, err = o.Raw(sql, promotions, gifts).Exec()
	return
}

// GetPromotionGiftByPromotions retrieves PromotionGift by Promotions. Returns error if
// Promotions doesn't exist
func GetPromotionGiftByPromotions(promotions int) (v []PromotionGift, err error) {
	o := orm.NewOrm()
	sql := "SELECT `promotions`, `gifts` FROM `promotion_gift` WHERE `promotions` = ?"
	if num, err := o.Raw(sql, promotions).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

// DeletePromotionGift deletes PromotionGift by promotions and gifts. Returns error if
// the record to be deleted doesn't exist
func DeletePromotionGift(promotions int, gifts int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `promotion_gift` WHERE `promotions` = ? AND `gifts` = ?"
	if num, err := o.Raw(sql, promotions, gifts).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

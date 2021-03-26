package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
)

type PromotionProductCategory struct {
	Promotions        int `orm:"column(promotions);" description:"促销Id"`
	ProductCategories int `orm:"column(product_categories);" description:"商品分类Id"`
}

// AddPromotionProductCategory insert a new PromotionProductCategory into database
func AddPromotionProductCategory(promotions int, productCategories int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `promotion_product_category` (`promotions`, `product_categories`) VALUES(?, ?)"
	_, err = o.Raw(sql, promotions, productCategories).Exec()
	return
}

// GetPromotionProductCategoryByProductCategory retrieves PromotionProductCategory by ProductCategories. Returns error if
// ProductCategories doesn't exist
func GetPromotionProductCategoryByProductCategory(productCategories int) (v []PromotionProductCategory, err error) {
	o := orm.NewOrm()
	sql := "SELECT `promotions`, `product_categories` FROM `promotion_product_category` WHERE `product_categories` = ?"
	if num, err := o.Raw(sql, productCategories).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

// DeletePromotionProductCategory deletes PromotionProductCategory by promotions and productCategories. Returns error if
// the record to be deleted doesn't exist
func DeletePromotionProductCategory(promotions int, productCategories int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `promotion_product_category` WHERE `promotions` = ? AND `product_categories` = ?"
	if num, err := o.Raw(sql, promotions, productCategories).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

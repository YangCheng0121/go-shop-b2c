package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
)

type PromotionMemberRank struct {
	Promotions  int `orm:"column(promotions);rel(fk)"`
	MemberRanks int `orm:"column(member_ranks);rel(fk)"`
}

// AddPromotionMemberRank insert a new PromotionMemberRank into database
func AddPromotionMemberRank(promotions int, memberRanks int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `promotion_member_rank` (`promotions`, `member_ranks`) VALUES(?, ?)"
	_, err = o.Raw(sql, promotions, memberRanks).Exec()
	return
}

// GetPromotionMemberRankByPromotions retrieves PromotionMemberRank by Promotions. Returns error if
// Promotions doesn't exist
func GetPromotionMemberRankByPromotions(promotions int) (v []PromotionMemberRank, err error) {
	o := orm.NewOrm()
	sql := "SELECT `promotions`, `member_ranks` FROM `promotion_member_rank` WHERE `promotions` = ?"
	if num, err := o.Raw(sql, promotions).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

// DeletePromotionMemberRank deletes PromotionMemberRank by promotions and memberRanks. Returns error if
// the record to be deleted doesn't exist
func DeletePromotionMemberRank(promotions int, memberRanks int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `promotion_member_rank` WHERE `promotions` = ? AND `member_ranks` = ?"
	if num, err := o.Raw(sql, promotions, memberRanks).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

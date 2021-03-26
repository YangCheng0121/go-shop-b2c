package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
)

type AdminRole struct {
	Admins int64 `orm:"column(admins);" description:"管理员 Id"`
	Roles  int64 `orm:"column(roles);" description:"Role Id"`
}

// AddAdminRole insert a new AdminRole into database and returns
// last inserted Id on success.
func AddAdminAndRole(admins int64, roles int64) (err error) {
	o := orm.NewOrm()
	_, err = o.Raw("INSERT INTO `admin_role` (`admins`, `roles`) VALUES(?, ?)", admins, roles).Exec()
	return
}

// GetAdminRoleIdByAdmins retrieves Roles by Admins. Returns error if
// Roles or IsEnabled doesn't exist
func GetAdminRoleIdByAdmins(admins int64) (v []AdminRole, err error) {
	o := orm.NewOrm()
	sql := "SELECT `admins`, `roles` FROM `admin_role` WHERE `admins` = ?"
	if num, err := o.Raw(sql, admins).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

// DeleteAdminRole deletes AdminRole by admins and roles. Returns error if
// the record to be deleted doesn't exist
func DeleteAdminRole(admins int, roles int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `admin_role` WHERE `admins` = ? AND `roles` = ?"
	if num, err := o.Raw(sql, admins, roles).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

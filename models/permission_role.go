package models

import (
	"fmt"

	"github.com/astaxie/beego/orm"
)

type PermissionRole struct {
	Permissions int `orm:"column(permissions);rel(fk)"`
	Roles       int `orm:"column(roles);rel(fk)" description:"角色"`
}

// AddPermissionRole insert a new PermissionRole into database
func AddPermissionRole(permissions int, roles int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `permission_role` (`permissions`, `roles`) VALUES(?, ?)"
	_, err = o.Raw(sql, permissions, roles).Exec()
	return
}

// GetPermissionRoleByRole retrieves PermissionRole by Role. Returns error if
// Role doesn't exist
func GetPermissionRoleByRole(roles int) (v []PermissionRole, err error) {
	o := orm.NewOrm()
	sql := "SELECT `permissions`, `roles` FROM `permission_role` WHERE `roles` = ?"
	if num, err := o.Raw(sql, roles).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

// DeletePermissionRole deletes PermissionRole by permissions and roles. Returns error if
// the record to be deleted doesn't exist
func DeletePermissionRole(permissions int, roles int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM `permission_role` WHERE `permissions` = ? AND `roles` = ?"
	if num, err := o.Raw(sql, permissions, roles).Exec(); err == nil {
		fmt.Println("Number of records deleted in database:", num)
	}
	return
}

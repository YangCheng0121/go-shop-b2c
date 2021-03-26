package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Admin struct {
	Id                int64     `orm:"column(id);auto" description:"主键_id"`
	Name              string    `orm:"column(name);size(255)" description:"姓名"`
	Username          string    `orm:"column(username);size(100)" description:"用户名"`
	Password          string    `orm:"column(password);size(255)" description:"密码"`
	Hasher            string    `orm:"column(hasher);size(200)" description:"加密类型"`
	Salt              string    `orm:"column(salt);size(200)" description:"加密盐"`
	Department        string    `orm:"column(department);size(255);null" description:"部门"`
	Email             string    `orm:"column(email);size(255)" description:"E-mail"`
	IsEnabled         int8      `orm:"column(is_enabled)" description:"是否启用"`
	IsLocked          int8      `orm:"column(is_locked)" description:"是否锁定"`
	LockedDate        time.Time `orm:"column(locked_date);type(datetime);null" description:"锁定日期"`
	LoginDate         time.Time `orm:"column(login_date);auto_now;type(datetime);null" description:"最后登录日期"`
	LoginIp           string    `orm:"column(login_ip);size(255);null" description:"最后登录IP "`
	LoginFailureCount int       `orm:"column(login_failure_count)" description:"连续登录失败次数"`
	CreateBy          string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate      time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy     string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate   time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag        int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Admin) TableName() string {
	return "admin"
}

func init() {
	orm.RegisterModel(new(Admin))
}

// AddAdmin insert a new Admin into database and returns
// last inserted Id on success.
func AddAdmin(m *Admin) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetAdminById retrieves Admin by Id. Returns error if
// Id doesn't exist
func GetAdminById(id int64) (v *Admin, err error) {
	o := orm.NewOrm()
	v = &Admin{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAdminByUsername retrieves Admin by Username. Returns error if
// Username doesn't exist
func GetAdminByUsername(username string) (v *Admin, err error) {
	o := orm.NewOrm()
	v = &Admin{Username: username}
	if err = o.Read(v, "Username"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAdminByUsernameAndIsEnabled retrieves Admin by Username and isEnabled. Returns error if
// Username or IsEnabled doesn't exist
func GetAdminByUsernameAndIsEnabled(username string, isEnabled int) (v *Admin, err error) {
	o := orm.NewOrm()
	v = &Admin{}
	if err = o.QueryTable(v.TableName()).Filter("username", username).Filter("is_enabled", isEnabled).One(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAdminCount calculate Admin Count. Returns error if
// Table doesn't exist
func GetAdminCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Admin))
	// query k=v
	for k, v := range query {
		// rewrite dot-notation to Object__Attribute
		k = strings.Replace(k, ".", "__", -1)
		if strings.Contains(k, "isnull") {
			qs = qs.Filter(k, (v == "true" || v == "1"))
		} else {
			qs = qs.Filter(k, v)
		}
	}
	if cnt, err := qs.Count(); err == nil {
		return cnt, nil
	}
	return 0, err
}

// GetAllAdmin retrieves all Admin matches certain condition. Returns empty list if
// no records exist
func GetAllAdmin(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Admin))
	// query k=v
	for k, v := range query {
		// rewrite dot-notation to Object__Attribute
		k = strings.Replace(k, ".", "__", -1)
		if strings.Contains(k, "isnull") {
			qs = qs.Filter(k, (v == "true" || v == "1"))
		} else {
			qs = qs.Filter(k, v)
		}
	}
	// order by:
	var sortFields []string
	if len(sortby) != 0 {
		if len(sortby) == len(order) {
			// 1) for each sort field, there is an associated order
			for i, v := range sortby {
				orderby := ""
				if order[i] == "desc" {
					orderby = "-" + v
				} else if order[i] == "asc" {
					orderby = v
				} else {
					return nil, errors.New("Error: Invalid order. Must be either [asc|desc]")
				}
				sortFields = append(sortFields, orderby)
			}
			qs = qs.OrderBy(sortFields...)
		} else if len(sortby) != len(order) && len(order) == 1 {
			// 2) there is exactly one order, all the sorted fields will be sorted by this order
			for _, v := range sortby {
				orderby := ""
				if order[0] == "desc" {
					orderby = "-" + v
				} else if order[0] == "asc" {
					orderby = v
				} else {
					return nil, errors.New("Error: Invalid order. Must be either [asc|desc]")
				}
				sortFields = append(sortFields, orderby)
			}
		} else if len(sortby) != len(order) && len(order) != 1 {
			return nil, errors.New("Error: 'sortby', 'order' sizes mismatch or 'order' size is not 1")
		}
	} else {
		if len(order) != 0 {
			return nil, errors.New("Error: unused 'order' fields")
		}
	}

	var l []Admin
	qs = qs.OrderBy(sortFields...)
	if _, err = qs.Limit(limit, offset).All(&l, fields...); err == nil {
		if len(fields) == 0 {
			for _, v := range l {
				ml = append(ml, v)
			}
		} else {
			// trim unused fields
			for _, v := range l {
				m := make(map[string]interface{})
				val := reflect.ValueOf(v)
				for _, fname := range fields {
					m[fname] = val.FieldByName(fname).Interface()
				}
				ml = append(ml, m)
			}
		}
		return ml, nil
	}
	return nil, err
}

// UpdateAdmin updates Admin by Id and returns error if
// the record to be updated doesn't exist
func UpdateAdminById(m *Admin) (err error) {
	o := orm.NewOrm()
	v := Admin{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteAdmin deletes Admin by Id and returns error if
// the record to be deleted doesn't exist
func DeleteAdmin(id int64) (err error) {
	o := orm.NewOrm()
	v := Admin{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Admin{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

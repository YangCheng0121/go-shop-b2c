package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Sms struct {
	Id              int        `orm:"column(id);auto" description:"主键_id"`
	Mobile          string     `orm:"column(mobile);size(255)" description:"手机"`
	Code            string     `orm:"column(code);size(50)" description:"短信值"`
	Type            int        `orm:"column(type)" description:"短信类型"`
	ExpireDate      *time.Time `orm:"column(expire_date);type(datetime);null" description:"过期日期"`
	UsedDate        *time.Time `orm:"column(used_date);type(datetime);null" description:"使用日期"`
	IsUsed          int8       `orm:"column(is_used)" description:"是否已使用"`
	CreateBy        string     `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time  `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string     `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time  `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
}

func (t *Sms) TableName() string {
	return "sms"
}

func init() {
	orm.RegisterModel(new(Sms))
}

// AddSms insert a new Sms into database and returns
// last inserted Id on success.
func AddSms(m *Sms) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetSmsById retrieves Sms by Id. Returns error if
// Id doesn't exist
func GetSmsById(id int) (v *Sms, err error) {
	o := orm.NewOrm()
	v = &Sms{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetSmsByCodeAndMobile retrieves Sms and Mobile by Code. Returns error if
// Id doesn't exist
func GetSmsByCodeAndMobile(code string, mobile string) (v *Sms, err error) {
	o := orm.NewOrm()
	v = &Sms{Code: code, Mobile: mobile}
	if err = o.Read(v, "Code", "Mobile"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAllSms retrieves all Sms matches certain condition. Returns empty list if
// no records exist
func GetAllSms(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Sms))
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

	var l []Sms
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

// UpdateSms updates Sms by Id and returns error if
// the record to be updated doesn't exist
func UpdateSmsById(m *Sms) (err error) {
	o := orm.NewOrm()
	v := Sms{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteSms deletes Sms by Id and returns error if
// the record to be deleted doesn't exist
func DeleteSms(id int) (err error) {
	o := orm.NewOrm()
	v := Sms{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Sms{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

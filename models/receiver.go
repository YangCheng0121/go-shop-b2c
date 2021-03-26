package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Receiver struct {
	Id              int       `orm:"column(id);auto" description:"id"`
	Consignee       string    `orm:"column(consignee);size(255)" description:"收货人"`
	AreaName        string    `orm:"column(area_name);size(255)" description:"地区名称"`
	Address         string    `orm:"column(address);size(255)" description:"地址"`
	ZipCode         string    `orm:"column(zip_code);size(255)" description:"邮编"`
	Phone           string    `orm:"column(phone);size(255)" description:"电话"`
	IsDefault       int8      `orm:"column(is_default)" description:"是否默认"`
	AreaId          int64     `orm:"column(area_id);null" description:"地区"`
	MemberId        int64     `orm:"column(member_id)" description:"会员"`
	CreateBy        string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Receiver) TableName() string {
	return "receiver"
}

func init() {
	orm.RegisterModel(new(Receiver))
}

// AddReceiver insert a new Receiver into database and returns
// last inserted Id on success.
func AddReceiver(m *Receiver) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetReceiverById retrieves Receiver by Id. Returns error if
// Id doesn't exist
func GetReceiverById(id int) (v *Receiver, err error) {
	o := orm.NewOrm()
	v = &Receiver{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetReceiverByIdAndMemberId retrieves Receiver by Id and MemberId. Returns error if
// Id or MemberId doesn't exist
func GetReceiverByIdAndMemberId(id int, memberId int) (v *Receiver, err error) {
	o := orm.NewOrm()
	v = &Receiver{Id: id, MemberId: int64(memberId)}
	if err = o.Read(v, "Id", "MemberId"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetDefaultReceiverByMemberId retrieves Receiver by MemberId. Returns error if
// MemberId doesn't exist
func GetDefaultReceiverByMemberId(memberId int) (v *Receiver, err error) {
	o := orm.NewOrm()
	v = &Receiver{MemberId: int64(memberId), IsDefault: 1}
	if err = o.Read(v, "MemberId", "IsDefault"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetReceiverCount calculate Receiver Count. Returns error if
// Table doesn't exist
func GetReceiverCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Receiver))
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

// GetAllReceiver retrieves all Receiver matches certain condition. Returns empty list if
// no records exist
func GetAllReceiver(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Receiver))
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

	var l []Receiver
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

// UpdateReceiver updates Receiver by Id and returns error if
// the record to be updated doesn't exist
func UpdateReceiverById(m *Receiver) (err error) {
	o := orm.NewOrm()
	v := Receiver{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteReceiver deletes Receiver by Id and returns error if
// the record to be deleted doesn't exist
func DeleteReceiver(id int) (err error) {
	o := orm.NewOrm()
	v := Receiver{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Receiver{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

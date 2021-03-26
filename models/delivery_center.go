package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type DeliveryCenter struct {
	Id              int       `orm:"column(id);pk" description:"主键_id"`
	Name            string    `orm:"column(name);size(255)" description:"名称"`
	Contact         string    `orm:"column(contact);size(255)" description:"联系人"`
	Mobile          string    `orm:"column(mobile);size(255);null" description:"手机"`
	Phone           string    `orm:"column(phone);size(255);null" description:"电话"`
	AreaId          int64     `orm:"column(area_id);null" description:"地区"`
	AreaName        string    `orm:"column(area_name);size(255)" description:"地区名称"`
	ZipCode         string    `orm:"column(zip_code);size(255);null" description:"邮编"`
	Address         string    `orm:"column(address);size(255)" description:"地址"`
	IsDefault       int8      `orm:"column(is_default)" description:"是否默认"`
	Memo            string    `orm:"column(memo);size(255);null" description:"备注"`
	CreateBy        string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *DeliveryCenter) TableName() string {
	return "delivery_center"
}

func init() {
	orm.RegisterModel(new(DeliveryCenter))
}

// AddDeliveryCenter insert a new DeliveryCenter into database and returns
// last inserted Id on success.
func AddDeliveryCenter(m *DeliveryCenter) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetDeliveryCenterById retrieves DeliveryCenter by Id. Returns error if
// Id doesn't exist
func GetDeliveryCenterById(id int) (v *DeliveryCenter, err error) {
	o := orm.NewOrm()
	v = &DeliveryCenter{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetDeliveryCenterCount calculate DeliveryCenter Count. Returns error if
// Table doesn't exist
func GetDeliveryCenterCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(DeliveryCenter))
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

// GetAllDeliveryCenter retrieves all DeliveryCenter matches certain condition. Returns empty list if
// no records exist
func GetAllDeliveryCenter(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(DeliveryCenter))
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

	var l []DeliveryCenter
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

// UpdateDeliveryCenter updates DeliveryCenter by Id and returns error if
// the record to be updated doesn't exist
func UpdateDeliveryCenterById(m *DeliveryCenter) (err error) {
	o := orm.NewOrm()
	v := DeliveryCenter{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteDeliveryCenter deletes DeliveryCenter by Id and returns error if
// the record to be deleted doesn't exist
func DeleteDeliveryCenter(id int) (err error) {
	o := orm.NewOrm()
	v := DeliveryCenter{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&DeliveryCenter{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

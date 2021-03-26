package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type ShippingMethod struct {
	Id                    int           `orm:"column(id);auto"`
	Name                  string        `orm:"column(name);size(255)" description:"名称"`
	FirstWeight           int           `orm:"column(first_weight)" description:"首重量"`
	ContinueWeight        int           `orm:"column(continue_weight)" description:"续重量"`
	FirstPrice            float64       `orm:"column(first_price);digits(21);decimals(6)" description:"首重价格"`
	ContinuePrice         float64       `orm:"column(continue_price);digits(21);decimals(6)" description:"续重价格"`
	Orders                int           `orm:"column(orders);null" description:"订单"`
	Icon                  string        `orm:"column(icon);size(255);null" description:"图标"`
	Description           string        `orm:"column(description);null" description:"description"`
	DefaultDeliveryCorpId *DeliveryCorp `orm:"column(default_delivery_corp_id);rel(fk)" description:"默认物流公司"`
	CreateBy              string        `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate          time.Time     `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy         string        `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate       time.Time     `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag            int8          `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *ShippingMethod) TableName() string {
	return "shipping_method"
}

func init() {
	orm.RegisterModel(new(ShippingMethod))
}

// AddShippingMethod insert a new ShippingMethod into database and returns
// last inserted Id on success.
func AddShippingMethod(m *ShippingMethod) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetShippingMethodById retrieves ShippingMethod by Id. Returns error if
// Id doesn't exist
func GetShippingMethodById(id int) (v *ShippingMethod, err error) {
	o := orm.NewOrm()
	v = &ShippingMethod{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetShippingMethodCount calculate ShippingMethod Count. Returns error if
// Table doesn't exist
func GetShippingMethodCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(ShippingMethod))
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

// GetAllShippingMethod retrieves all ShippingMethod matches certain condition. Returns empty list if
// no records exist
func GetAllShippingMethod(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(ShippingMethod))
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

	var l []ShippingMethod
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

// UpdateShippingMethod updates ShippingMethod by Id and returns error if
// the record to be updated doesn't exist
func UpdateShippingMethodById(m *ShippingMethod) (err error) {
	o := orm.NewOrm()
	v := ShippingMethod{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteShippingMethod deletes ShippingMethod by Id and returns error if
// the record to be deleted doesn't exist
func DeleteShippingMethod(id int) (err error) {
	o := orm.NewOrm()
	v := ShippingMethod{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&ShippingMethod{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

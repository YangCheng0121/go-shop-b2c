package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type PaymentLog struct {
	Id                int       `orm:"column(id);auto" description:"主键_id"`
	Amount            float64   `orm:"column(amount);digits(20);decimals(6)" description:"支付金额"`
	Fee               float64   `orm:"column(fee);digits(20);decimals(6)" description:"支付手续费"`
	PaymentPluginId   string    `orm:"column(payment_plugin_id);size(255)" description:"支付插件ID"`
	PaymentPluginName string    `orm:"column(payment_plugin_name);size(255)" description:"支付插件名称"`
	Sn                string    `orm:"column(sn);size(255)" description:"编号"`
	Status            int       `orm:"column(status)" description:"状态"`
	Type              int       `orm:"column(type)" description:"类型"`
	Memo              string    `orm:"column(memo);size(255);null" description:"备注"`
	MemberId          *Member   `orm:"column(member_id);rel(fk)" description:"会员"`
	OrderId           *Order    `orm:"column(order_id);rel(fk)" description:"订单"`
	CreateBy          string    `orm:"column(create_by);size(255);null" description:"创建人"`
	CreationDate      time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy     time.Time `orm:"column(last_updated_by);type(datetime);null" description:"最后修改人"`
	LastUpdatedDate   time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag        int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *PaymentLog) TableName() string {
	return "payment_log"
}

func init() {
	orm.RegisterModel(new(PaymentLog))
}

// AddPaymentLog insert a new PaymentLog into database and returns
// last inserted Id on success.
func AddPaymentLog(m *PaymentLog) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetPaymentLogById retrieves PaymentLog by Id. Returns error if
// Id doesn't exist
func GetPaymentLogById(id int) (v *PaymentLog, err error) {
	o := orm.NewOrm()
	v = &PaymentLog{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAllPaymentLog retrieves all PaymentLog matches certain condition. Returns empty list if
// no records exist
func GetAllPaymentLog(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(PaymentLog))
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

	var l []PaymentLog
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

// UpdatePaymentLog updates PaymentLog by Id and returns error if
// the record to be updated doesn't exist
func UpdatePaymentLogById(m *PaymentLog) (err error) {
	o := orm.NewOrm()
	v := PaymentLog{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeletePaymentLog deletes PaymentLog by Id and returns error if
// the record to be deleted doesn't exist
func DeletePaymentLog(id int) (err error) {
	o := orm.NewOrm()
	v := PaymentLog{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&PaymentLog{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

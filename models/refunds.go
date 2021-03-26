package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Refunds struct {
	Id              int       `orm:"column(id);auto" description:"id"`
	Sn              string    `orm:"column(sn);size(100)" description:"编号"`
	IsReview        int8      `orm:"column(is_review);" description:"是否审核通过"`
	Method          int       `orm:"column(method)" description:"方式"`
	PaymentMethod   string    `orm:"column(payment_method);size(255)" description:"支付方式"`
	Bank            string    `orm:"column(bank);size(255);null" description:"退款银行"`
	Account         string    `orm:"column(account);size(255);null" description:"退款账号"`
	Amount          float64   `orm:"column(amount);digits(21);decimals(6)" description:"退款金额"`
	Payee           string    `orm:"column(payee);size(255);null" description:"收款人"`
	Operator        string    `orm:"column(operator);size(255)" description:"操作员"`
	Memo            string    `orm:"column(memo);size(255);null" description:"备注"`
	OrderId         *Order    `orm:"column(order_id);rel(fk)" description:"订单"`
	CreateBy        string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Refunds) TableName() string {
	return "refunds"
}

func init() {
	orm.RegisterModel(new(Refunds))
}

// AddRefunds insert a new Refunds into database and returns
// last inserted Id on success.
func AddRefunds(m *Refunds) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetRefundsById retrieves Refunds by Id. Returns error if
// Id doesn't exist
func GetRefundsById(id int) (v *Refunds, err error) {
	o := orm.NewOrm()
	v = &Refunds{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetRefundsBySn retrieves Refunds by Sn. Returns error if
// Sn doesn't exist
func GetRefundsBySn(sn string) (v *Refunds, err error) {
	o := orm.NewOrm()
	v = &Refunds{Sn: sn}
	if err = o.Read(v, "Sn"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetRefundsCount calculate Sku Count. Returns error if
// Table doesn't exist
func GetRefundsCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Refunds))
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

// GetAllRefunds retrieves all Refunds matches certain condition. Returns empty list if
// no records exist
func GetAllRefunds(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Refunds))
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

	var l []Refunds
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

// UpdateRefunds updates Refunds by Id and returns error if
// the record to be updated doesn't exist
func UpdateRefundsById(m *Refunds) (err error) {
	o := orm.NewOrm()
	v := Refunds{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteRefunds deletes Refunds by Id and returns error if
// the record to be deleted doesn't exist
func DeleteRefunds(id int) (err error) {
	o := orm.NewOrm()
	v := Refunds{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Refunds{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

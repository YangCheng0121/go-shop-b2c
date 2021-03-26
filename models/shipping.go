package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Shipping struct {
	Id               int       `orm:"column(id);auto" description:"id"`
	Sn               string    `orm:"column(sn);size(100)" description:"编号"`
	ShippingMethod   string    `orm:"column(shipping_method);size(255)" description:"配送方式"`
	DeliveryCorp     string    `orm:"column(delivery_corp);size(255)" description:"物流公司"`
	DeliveryCorpUrl  string    `orm:"column(delivery_corp_url);size(255);null" description:"物流公司网址"`
	DeliveryCorpCode string    `orm:"column(delivery_corp_code);size(255);null" description:"物流公司代码"`
	TrackingNo       string    `orm:"column(tracking_no);size(255);null" description:"运单号"`
	Freight          float64   `orm:"column(freight);null;digits(21);decimals(6)" description:"物流费用"`
	Consignee        string    `orm:"column(consignee);size(255)" description:"收货人"`
	Area             string    `orm:"column(area);size(255)" description:"地区"`
	Address          string    `orm:"column(address);size(255)" description:"地址"`
	ZipCode          string    `orm:"column(zip_code);size(255)" description:"邮编"`
	Phone            string    `orm:"column(phone);size(255)" description:"电话"`
	Operator         string    `orm:"column(operator);size(255)" description:"操作员"`
	Memo             string    `orm:"column(memo);size(255);null" description:"备注"`
	OrderId          int64     `orm:"column(order_id)" description:"订单"`
	CreateBy         string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate     time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy    string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate  time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag       int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Shipping) TableName() string {
	return "shipping"
}

func init() {
	orm.RegisterModel(new(Shipping))
}

// AddShipping insert a new Shipping into database and returns
// last inserted Id on success.
func AddShipping(m *Shipping) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetShippingById retrieves Shipping by Id. Returns error if
// Id doesn't exist
func GetShippingById(id int) (v *Shipping, err error) {
	o := orm.NewOrm()
	v = &Shipping{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetShippingBySn retrieves Shipping by Sn. Returns error if
// Sn doesn't exist
func GetShippingBySn(sn string) (v *Shipping, err error) {
	o := orm.NewOrm()
	v = &Shipping{Sn: sn}
	if err = o.Read(v, "Sn"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetShippingByOrderId retrieves Shipping by OrderId. Returns error if
// OrderId doesn't exist
func GetShippingByOrderId(orderId int64) (v *Shipping, err error) {
	o := orm.NewOrm()
	v = &Shipping{OrderId: orderId}
	if err = o.Read(v, "OrderId"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetShippingCount calculate Shipping Count. Returns error if
// Table doesn't exist
func GetShippingCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Shipping))
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

// GetAllShipping retrieves all Shipping matches certain condition. Returns empty list if
// no records exist
func GetAllShipping(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Shipping))
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

	var l []Shipping
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

// UpdateShipping updates Shipping by Id and returns error if
// the record to be updated doesn't exist
func UpdateShippingById(m *Shipping) (err error) {
	o := orm.NewOrm()
	v := Shipping{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteShipping deletes Shipping by Id and returns error if
// the record to be deleted doesn't exist
func DeleteShipping(id int) (err error) {
	o := orm.NewOrm()
	v := Shipping{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Shipping{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

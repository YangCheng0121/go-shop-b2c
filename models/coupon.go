package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Coupon struct {
	Id              int        `orm:"column(id);auto" description:"主键_id"`
	Name            string     `orm:"column(name);size(255)" description:"名称"`
	Condition       string     `orm:"column(condition);size(255)" description:"条件"`
	Prefix          string     `orm:"column(prefix);size(255)" description:"前缀"`
	Introduction    string     `orm:"column(introduction);null" description:"介绍"`
	BeginDate       *time.Time `orm:"column(begin_date);type(datetime);null" description:"使用起始日期"`
	EndDate         *time.Time `orm:"column(end_date);type(datetime);null" description:"使用结束日期"`
	IsEnabled       int8       `orm:"column(is_enabled)" description:"是否启用"`
	IsExchange      int8       `orm:"column(is_exchange)" description:"是否允许积分兑换"`
	MaximumPrice    float64    `orm:"column(maximum_price);null;digits(21);decimals(6)" description:"最大商品价格"`
	MaximumQuantity int        `orm:"column(maximum_quantity);null" description:"最大商品数量"`
	MinimumPrice    float64    `orm:"column(minimum_price);null;digits(21);decimals(6)" description:"最小商品价格"`
	MinimumQuantity int        `orm:"column(minimum_quantity);null" description:"最小商品数量"`
	Point           int64      `orm:"column(point);null" description:"积分兑换数"`
	PriceExpression string     `orm:"column(price_expression);size(255);null" description:"价格运算表达式"`
	CreateBy        string     `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time  `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string     `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time  `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8       `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Coupon) TableName() string {
	return "coupon"
}

func init() {
	orm.RegisterModel(new(Coupon))
}

// AddCoupon insert a new Coupon into database and returns
// last inserted Id on success.
func AddCoupon(m *Coupon) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetCouponById retrieves Coupon by Id. Returns error if
// Id doesn't exist
func GetCouponById(id int) (v *Coupon, err error) {
	o := orm.NewOrm()
	v = &Coupon{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetCouponCount calculate Coupon Count. Returns error if
// Table doesn't exist
func GetCouponCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Coupon))
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

// GetAllCoupon retrieves all Coupon matches certain condition. Returns empty list if
// no records exist
func GetAllCoupon(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Coupon))
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

	var l []Coupon
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

// UpdateCoupon updates Coupon by Id and returns error if
// the record to be updated doesn't exist
func UpdateCouponById(m *Coupon) (err error) {
	o := orm.NewOrm()
	v := Coupon{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteCoupon deletes Coupon by Id and returns error if
// the record to be deleted doesn't exist
func DeleteCoupon(id int) (err error) {
	o := orm.NewOrm()
	v := Coupon{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Coupon{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type OrderItem struct {
	Id              int       `orm:"column(id);auto" description:"主键_id"`
	Sn              string    `orm:"column(sn);size(255)" description:"商品编号"`
	Name            string    `orm:"column(name);size(255)" description:"商品名称"`
	Price           float64   `orm:"column(price);digits(21);decimals(6)" description:"商品价格"`
	Weight          int       `orm:"column(weight);null" description:"商品重量"`
	Specifications  string    `orm:"column(specifications);" description:"规格"`
	Thumbnail       string    `orm:"column(thumbnail);size(255);null" description:"商品缩略图"`
	Quantity        int       `orm:"column(quantity)" description:"数量"`
	ShippedQuantity int       `orm:"column(shipped_quantity)" description:"已发货数量"`
	ReturnQuantity  int       `orm:"column(return_quantity)" description:"已退货数量"`
	OrderId         *Order    `orm:"column(order_id);rel(fk)" description:"订单"`
	IsGift          int8      `orm:"column(is_gift)" description:"是否为赠品"`
	IsDelivery      int8      `orm:"column(is_delivery)" description:"是否需要物流"`
	SkuId           *Sku      `orm:"column(sku_id);rel(fk)" description:"SKU"`
	CreateBy        string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *OrderItem) TableName() string {
	return "order_item"
}

func init() {
	orm.RegisterModel(new(OrderItem))
}

// AddOrderItem insert a new OrderItem into database and returns
// last inserted Id on success.
func AddOrderItem(m *OrderItem) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetOrderItemById retrieves OrderItem by Id. Returns error if
// Id doesn't exist
func GetOrderItemById(id int) (v *OrderItem, err error) {
	o := orm.NewOrm()
	v = &OrderItem{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetOrderItemBySn retrieves OrderItem by Sn and OrderId. Returns error if
// Sn doesn't exist
func GetOrderItemBySnAndOrderId(sn string, orderId int) (v *OrderItem, err error) {
	o := orm.NewOrm()
	order := &Order{Id: orderId}
	v = &OrderItem{Sn: sn, OrderId: order}
	if err = o.Read(v, "Sn", "OrderId"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetOrderItemCount calculate Sku Count. Returns error if
// Table doesn't exist
func GetOrderItemCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(OrderItem))
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

// GetAllOrderItem retrieves all OrderItem matches certain condition. Returns empty list if
// no records exist
func GetAllOrderItem(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(OrderItem))
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

	var l []OrderItem
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

// UpdateOrderItem updates OrderItem by Id and returns error if
// the record to be updated doesn't exist
func UpdateOrderItemById(m *OrderItem) (err error) {
	o := orm.NewOrm()
	v := OrderItem{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteOrderItem deletes OrderItem by Id and returns error if
// the record to be deleted doesn't exist
func DeleteOrderItem(id int) (err error) {
	o := orm.NewOrm()
	v := OrderItem{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&OrderItem{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

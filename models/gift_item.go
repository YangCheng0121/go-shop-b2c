package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type GiftItem struct {
	Id              int        `orm:"column(id);auto" description:"主键_id"`
	Gift            *Product   `orm:"column(gift);rel(fk)" description:"赠品"`
	Quantity        int        `orm:"column(quantity)" description:"数量"`
	PromotionId     *Promotion `orm:"column(promotion_id);rel(fk)" description:"促销"`
	CreateBy        string     `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time  `orm:"column(creation_date);type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string     `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time  `orm:"column(last_updated_date);type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8       `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *GiftItem) TableName() string {
	return "gift_item"
}

func init() {
	orm.RegisterModel(new(GiftItem))
}

// AddGiftItem insert a new GiftItem into database and returns
// last inserted Id on success.
func AddGiftItem(m *GiftItem) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetGiftItemById retrieves GiftItem by Id. Returns error if
// Id doesn't exist
func GetGiftItemById(id int) (v *GiftItem, err error) {
	o := orm.NewOrm()
	v = &GiftItem{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAllGiftItem retrieves all GiftItem matches certain condition. Returns empty list if
// no records exist
func GetAllGiftItem(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(GiftItem))
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

	var l []GiftItem
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

// UpdateGiftItem updates GiftItem by Id and returns error if
// the record to be updated doesn't exist
func UpdateGiftItemById(m *GiftItem) (err error) {
	o := orm.NewOrm()
	v := GiftItem{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteGiftItem deletes GiftItem by Id and returns error if
// the record to be deleted doesn't exist
func DeleteGiftItem(id int) (err error) {
	o := orm.NewOrm()
	v := GiftItem{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&GiftItem{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

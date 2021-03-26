package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Ad struct {
	Id              int        `orm:"column(id);auto" description:"主键_id"`
	Title           string     `orm:"column(title);size(255)" description:"标题"`
	Type            int        `orm:"column(type)" description:"类型"`
	Content         string     `orm:"column(content);null" description:"内容"`
	AdPositionId    int64      `orm:"column(ad_position_id)" description:"广告位"`
	Path            string     `orm:"column(path);size(255);null" description:"路径"`
	Url             string     `orm:"column(url);size(255);null" description:"链接地址"`
	BeginDate       *time.Time `orm:"column(begin_date);type(datetime);null" description:"起始日期"`
	EndDate         *time.Time `orm:"column(end_date);type(datetime);null" description:"结束日期"`
	Orders          int        `orm:"column(orders);null" description:"排序"`
	CreateBy        string     `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time  `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string     `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time  `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8       `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Ad) TableName() string {
	return "ad"
}

func init() {
	orm.RegisterModel(new(Ad))
}

// AddAd insert a new Ad into database and returns
// last inserted Id on success.
func AddAd(m *Ad) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetAdById retrieves Ad by Id. Returns error if
// Id doesn't exist
func GetAdById(id int) (v *Ad, err error) {
	o := orm.NewOrm()
	v = &Ad{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetAdCount calculate Ad count. Returns error if
// Table doesn't exist
func GetAdCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Ad))
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

// GetAllAd retrieves all Ad matches certain condition. Returns empty list if
// no records exist
func GetAllAd(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Ad))
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

	var l []Ad
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

// UpdateAd updates Ad by Id and returns error if
// the record to be updated doesn't exist
func UpdateAdById(m *Ad) (err error) {
	o := orm.NewOrm()
	v := Ad{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteAd deletes Ad by Id and returns error if
// the record to be deleted doesn't exist
func DeleteAd(id int) (err error) {
	o := orm.NewOrm()
	v := Ad{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Ad{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Parameter struct {
	Id               int             `orm:"column(id);auto" description:"主键_id"`
	Name             string          `orm:"column(name);size(255)" description:"名称"`
	ParameterGroupId *ParameterGroup `orm:"column(parameter_group_id);rel(fk)" description:"参数组"`
	Orders           int             `orm:"column(orders);null" description:"排序"`
	CreateBy         string          `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate     time.Time       `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy    string          `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate  time.Time       `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag       int8            `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Parameter) TableName() string {
	return "parameter"
}

func init() {
	orm.RegisterModel(new(Parameter))
}

// AddParameter insert a new Parameter into database and returns
// last inserted Id on success.
func AddParameter(m *Parameter) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetParameterById retrieves Parameter by Id. Returns error if
// Id doesn't exist
func GetParameterById(id int) (v *Parameter, err error) {
	o := orm.NewOrm()
	v = &Parameter{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetParameterByIdAndGroup retrieves Parameter by Name and GroupId. Returns error if
// Name and GroupId doesn't exist
func GetParameterByNameAndGroupId(name string, groupId int) (v *Parameter, err error) {
	o := orm.NewOrm()
	var parameterGroup ParameterGroup
	parameterGroup.Id = groupId

	v = &Parameter{Name: name, ParameterGroupId: &parameterGroup}
	if err = o.Read(v, "Id", "ParameterGroupId"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetParameterCount calculate Tag Count. Returns error if
// Table doesn't exist
func GetParameterCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Parameter))
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

// GetAllParameter retrieves all Parameter matches certain condition. Returns empty list if
// no records exist
func GetAllParameter(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Parameter))
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

	var l []Parameter
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

// UpdateParameter updates Parameter by Id and returns error if
// the record to be updated doesn't exist
func UpdateParameterById(m *Parameter) (err error) {
	o := orm.NewOrm()
	v := Parameter{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteParameter deletes Parameter by Id and returns error if
// the record to be deleted doesn't exist
func DeleteParameter(id int) (err error) {
	o := orm.NewOrm()
	v := Parameter{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Parameter{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

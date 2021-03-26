package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Member struct {
	Id                int       `orm:"column(id);auto" description:"主键_id"`
	Username          string    `orm:"column(username);size(100)" description:"用户名"`
	Password          string    `orm:"column(password);size(255)" description:"密码"`
	Name              string    `orm:"column(name);size(255);null" description:"姓名"`
	Avatar            string    `orm:"column(avatar);size(255);null" description:"头像"`
	Gender            int       `orm:"column(gender);null" description:"性别,0未知,1男,2女"`
	Mobile            string    `orm:"column(mobile);size(255);null" description:"手机"`
	Phone             string    `orm:"column(phone);size(255);null" description:"电话"`
	Birth             time.Time `orm:"column(birth);type(datetime);null" description:"出生日期"`
	ZipCode           string    `orm:"column(zip_code);size(255);null" description:"邮编"`
	OpenId            string    `orm:"column(open_id);size(255);null" description:"openID"`
	AreaId            int64     `orm:"column(area_id);null" description:"地区"`
	Address           string    `orm:"column(address);size(255);null" description:"地址"`
	Email             string    `orm:"column(email);size(255);null" description:"E-mail"`
	Amount            float64   `orm:"column(amount);digits(27);decimals(12)" description:"消费金额"`
	Balance           float64   `orm:"column(balance);digits(27);decimals(12)" description:"余额"`
	Point             int64     `orm:"column(point)" description:"积分"`
	MemberRankId      int64     `orm:"column(member_rank_id)" description:"会员等级"`
	RegisterIp        string    `orm:"column(register_ip);size(255)" description:"注册IP"`
	AttributeValue0   string    `orm:"column(attribute_value0);size(255);null" description:"会员注册项值0"`
	AttributeValue1   string    `orm:"column(attribute_value1);size(255);null" description:"会员注册项值1"`
	AttributeValue2   string    `orm:"column(attribute_value2);size(255);null" description:"会员注册项值2"`
	AttributeValue3   string    `orm:"column(attribute_value3);size(255);null" description:"会员注册项值3"`
	AttributeValue4   string    `orm:"column(attribute_value4);size(255);null" description:"会员注册项值4"`
	AttributeValue5   string    `orm:"column(attribute_value5);size(255);null" description:"会员注册项值5"`
	AttributeValue6   string    `orm:"column(attribute_value6);size(255);null" description:"会员注册项值6"`
	AttributeValue7   string    `orm:"column(attribute_value7);size(255);null" description:"会员注册项值7"`
	AttributeValue8   string    `orm:"column(attribute_value8);size(255);null" description:"会员注册项值8"`
	AttributeValue9   string    `orm:"column(attribute_value9);size(255);null" description:"会员注册项值9"`
	IsEnabled         int8      `orm:"column(is_enabled)" description:"是否启用"`
	IsLocked          int8      `orm:"column(is_locked)" description:"是否锁定"`
	LockedDate        time.Time `orm:"column(locked_date);type(datetime);null" description:"锁定日期"`
	LoginDate         time.Time `orm:"column(login_date);auto_now;type(datetime);null" description:"最后登录日期"`
	LoginFailureCount int       `orm:"column(login_failure_count)" description:"连续登录失败次数"`
	LoginIp           string    `orm:"column(login_ip);size(255);null" description:"最后登录IP"`
	SafeKeyExpire     time.Time `orm:"column(safe_key_expire);type(datetime);null" description:"安全密匙有效期"`
	SafeKeyValue      string    `orm:"column(safe_key_value);size(255);null" description:"安全密匙值"`
	CreateBy          string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate      time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy     string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate   time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag        int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Member) TableName() string {
	return "member"
}

func init() {
	orm.RegisterModel(new(Member))
}

// AddMember insert a new Member into database and returns
// last inserted Id on success.
func AddMember(m *Member) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetMemberById retrieves Member by Id. Returns error if
// Id doesn't exist
func GetMemberById(id int) (v *Member, err error) {
	o := orm.NewOrm()
	v = &Member{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetMemberByUsername retrieves Member by Username. Returns error if
// Id doesn't exist
func GetMemberByUsername(username string) (v *Member, err error) {
	o := orm.NewOrm()
	v = &Member{Username: username}
	if err = o.Read(v, "Username"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetMemberByOpenId retrieves Member by OpenId. Returns error if
// OpenId doesn't exist
func GetMemberByOpenId(openId string) (v *Member, err error) {
	o := orm.NewOrm()
	v = &Member{OpenId: openId}
	if err = o.Read(v, "OpenId"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetMemberCount calculate Member Count. Returns error if
// Table doesn't exist
func GetMemberCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Member))
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

// GetAllMember retrieves all Member matches certain condition. Returns empty list if
// no records exist
func GetAllMember(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Member))
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

	var l []Member
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

// UpdateMember updates Member by Id and returns error if
// the record to be updated doesn't exist
func UpdateMemberById(m *Member) (err error) {
	o := orm.NewOrm()
	v := Member{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteMember deletes Member by Id and returns error if
// the record to be deleted doesn't exist
func DeleteMember(id int) (err error) {
	o := orm.NewOrm()
	v := Member{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Member{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

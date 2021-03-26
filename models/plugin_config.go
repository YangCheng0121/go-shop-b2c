package models

import (
	"encoding/json"
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type PluginConfig struct {
	Id              int       `orm:"column(id);auto" description:"主键_id"`
	PluginId        string    `orm:"column(plugin_id);size(100)" description:"插件ID"`
	Attributes      string    `orm:"column(attributes);null" description:"属性"`
	IsEnabled       int8      `orm:"column(is_enabled)" description:"是否启用"`
	Orders          int       `orm:"column(orders);null" description:"排序"`
	Type            int       `orm:"column(type);null" description:"类型"`
	CreateBy        string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8      `orm:"column(delete_flag)" description:"删除标记"`
}

type WeXinPayment struct {
	AppId       string `json:"appId" description:"AppId"`
	Fee         string `json:"fee" description:"手续费"`
	Logo        string `json:"logo" description:"Logo"`
	Description string `json:"description" description:"描述"`
	AppSecret   string `json:"appSecret" description:"App密钥"`
	MchId       string `json:"mch_id" description:"商户ID"`
	FeeType     string `json:"feeType" description:"手续费类型"`
	PaymentName string `json:"paymentName" description:"支付方式名称"`
	PaternerKey string `json:"paternerKey" description:"API密钥"`
	PluginId    string `json:"plugin_id" description:"插件ID"`
}

func (t *PluginConfig) TableName() string {
	return "plugin_config"
}

func init() {
	orm.RegisterModel(new(PluginConfig))
}

// AddPluginConfig insert a new PluginConfig into database and returns
// last inserted Id on success.
func AddPluginConfig(m *PluginConfig) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

/**
 * 获取支付插件
 */
func GetWeiXinPaymentPlugin() (weiXinPayment WeXinPayment) {
	paymentPlugin, err := GetPluginConfigByPluginIdAndIsEnabled("weixinPaymentPlugin", 1)
	if err != nil {
		return
	}
	_ = json.Unmarshal([]byte(paymentPlugin.Attributes), &weiXinPayment)
	weiXinPayment.PluginId = "weixinPaymentPlugin"
	return weiXinPayment
}

// GetPluginConfigById retrieves PluginConfig by Id. Returns error if
// Id doesn't exist
func GetPluginConfigById(id int) (v *PluginConfig, err error) {
	o := orm.NewOrm()
	v = &PluginConfig{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetPluginConfigById retrieves PluginConfig by PluginId and IsEnabled. Returns error if
// PluginId or IsEnabled doesn't exist
func GetPluginConfigByPluginIdAndIsEnabled(pluginId string, isEnabled int8) (v *PluginConfig, err error) {
	o := orm.NewOrm()
	v = &PluginConfig{PluginId: pluginId, IsEnabled: isEnabled}
	if err = o.Read(v, "PluginId", "IsEnabled"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetPluginConfigCount calculate Sku Count. Returns error if
// Table doesn't exist
func GetPluginConfigCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(PluginConfig))
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

// GetAllPluginConfig retrieves all PluginConfig matches certain condition. Returns empty list if
// no records exist
func GetAllPluginConfig(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(PluginConfig))
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

	var l []PluginConfig
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

// UpdatePluginConfig updates PluginConfig by Id and returns error if
// the record to be updated doesn't exist
func UpdatePluginConfigById(m *PluginConfig) (err error) {
	o := orm.NewOrm()
	v := PluginConfig{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeletePluginConfig deletes PluginConfig by Id and returns error if
// the record to be deleted doesn't exist
func DeletePluginConfig(id int) (err error) {
	o := orm.NewOrm()
	v := PluginConfig{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&PluginConfig{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

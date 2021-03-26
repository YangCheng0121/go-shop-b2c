package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Sku struct {
	Id                  int       `orm:"column(id);auto" description:"主键_id"`
	Stock               int       `orm:"column(stock)" description:"库存"`
	AllocatedStock      int       `orm:"column(allocated_stock)" description:"已分配库存"`
	Cost                float64   `orm:"column(cost);null;digits(21);decimals(6)" description:"成本价"`
	MarketPrice         float64   `orm:"column(market_price);digits(21);decimals(6)" description:"市场价"`
	Price               float64   `orm:"column(price);digits(22);decimals(6)" description:"售价"`
	ExchangePoint       int64     `orm:"column(exchange_point)" description:"兑换积分"`
	RewardPoint         int64     `orm:"column(reward_point)" description:"赠送积分"`
	Sn                  string    `orm:"column(sn);size(255)" description:"编号"`
	SpecificationValues string    `orm:"column(specification_values);null" description:"规格值"`
	ProductId           *Product  `orm:"column(product_id);rel(fk)" description:"商品"`
	IsDefault           int8      `orm:"column(is_default)" description:"是否默认"`
	IsEnable            int8      `orm:"column(is_enable)" description:"是否启用"`
	CreateBy            string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate        time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy       string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate     time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag          int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Sku) TableName() string {
	return "sku"
}

func init() {
	orm.RegisterModel(new(Sku))
}

// AddSku insert a new Sku into database and returns
// last inserted Id on success.
func AddSku(m *Sku) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetSkuById retrieves Sku by Id. Returns error if
// Id doesn't exist
func GetSkuById(id int) (v *Sku, err error) {
	o := orm.NewOrm()
	v = &Sku{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetSkuBySn retrieves Sku by sn. Returns error if
// sn doesn't exist
func GetSkuBySn(sn string) (v *Sku, err error) {
	o := orm.NewOrm()
	v = &Sku{Sn: sn}
	if err = o.Read(v, "Sn"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetSkuCount calculate Sku Count. Returns error if
// Table doesn't exist
func GetSkuCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Sku))
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

// GetSkuByProductName. Returns error if
// Table doesn't exist
func GetSkuByProductName(name string) (ml []Sku, err error) {
	o := orm.NewOrm()
	sql := "SELECT %v FROM sku "
	sql += "LEFT JOIN product ON sku.product_id = product.id "
	sql += "WHERE product.name LIKE ? "
	sql += "AND sku.delete_flag = 0 "

	fields := getFieldsWithSku()
	fieldsStr := strings.Join(fields, ",")
	sql = fmt.Sprintf(sql, fieldsStr)
	name = "%" + name + "%"
	if num, err := o.Raw(sql, name).QueryRows(&ml); err == nil && num > 0 {
		return ml, nil
	}
	return nil, err
}

func getFieldsWithSku() (fields []string) {
	fields = append(fields, "sku.id")
	fields = append(fields, "sku.sn")
	fields = append(fields, "sku.stock")
	fields = append(fields, "sku.allocated_stock")
	fields = append(fields, "sku.cost")
	fields = append(fields, "sku.market_price")
	fields = append(fields, "sku.reward_point")
	fields = append(fields, "sku.specification_values")
	fields = append(fields, "sku.product_id")
	fields = append(fields, "sku.is_default")
	fields = append(fields, "sku.is_enable")

	return fields
}

// GetAllSku retrieves all Sku matches certain condition. Returns empty list if
// no records exist
func GetAllSku(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Sku))
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

	var l []Sku
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

// UpdateSku updates Sku by Id and returns error if
// the record to be updated doesn't exist
func UpdateSkuById(m *Sku) (err error) {
	o := orm.NewOrm()
	v := Sku{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteSku deletes Sku by Id and returns error if
// the record to be deleted doesn't exist
func DeleteSku(id int) (err error) {
	o := orm.NewOrm()
	v := Sku{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Sku{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

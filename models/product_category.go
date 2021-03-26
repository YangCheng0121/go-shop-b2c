package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type ProductCategory struct {
	Id              int       `orm:"column(id);auto" description:"主键_id"`
	Name            string    `orm:"column(name);size(255)" description:"名称"`
	SeoTitle        string    `orm:"column(seo_title);size(255);null" description:"页面标题"`
	SeoKeywords     string    `orm:"column(seo_keywords);size(255);null" description:"页面关键词"`
	SeoDescription  string    `orm:"column(seo_description);size(255);null" description:"页面描述"`
	TreePath        string    `orm:"column(tree_path);size(255)" description:"树路径"`
	Grade           int       `orm:"column(grade)" description:"层级"`
	Image           string    `orm:"column(image)" description:"图片"`
	ParentId        *int      `orm:"column(parent_id);null" description:"上级分类"`
	Orders          int       `orm:"column(orders);null" description:"排序"`
	IsMarketable    int8      `orm:"column(is_marketable)" description:"是否上架"`
	IsTop           int8      `orm:"column(is_top)" description:"是否置顶"`
	IsShow          int8      `orm:"column(is_show)" description:"是否显示"`
	CreateBy        string    `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate    time.Time `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy   string    `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate time.Time `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag      int8      `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *ProductCategory) TableName() string {
	return "product_category"
}

func init() {
	orm.RegisterModel(new(ProductCategory))
}

// AddProductCategory insert a new ProductCategory into database and returns
// last inserted Id on success.
func AddProductCategory(m *ProductCategory) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetProductCategoryById retrieves ProductCategory by Id. Returns error if
// Id doesn't exist
func GetProductCategoryById(id int) (v *ProductCategory, err error) {
	o := orm.NewOrm()
	v = &ProductCategory{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetProductCategoryByName retrieves ProductCategory by Name. Returns error if
// Id doesn't exist
func GetProductCategoryByName(name string) (v *ProductCategory, err error) {
	o := orm.NewOrm()
	v = &ProductCategory{Name: name}
	if err = o.Read(v, "Name"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetProductCategoryCount calculate ProductCategoryCount count. Returns error if
// Table doesn't exist
func GetProductCategoryCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(ProductCategory))
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

// GetAllProductCategory retrieves all ProductCategory matches certain condition. Returns empty list if
// no records exist
func GetAllProductCategory(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(ProductCategory))
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

	var l []ProductCategory
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

// UpdateProductCategory updates ProductCategory by Id and returns error if
// the record to be updated doesn't exist
func UpdateProductCategoryById(m *ProductCategory) (err error) {
	o := orm.NewOrm()
	v := ProductCategory{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteProductCategory deletes ProductCategory by Id and returns error if
// the record to be deleted doesn't exist
func DeleteProductCategory(id int) (err error) {
	o := orm.NewOrm()
	v := ProductCategory{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&ProductCategory{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

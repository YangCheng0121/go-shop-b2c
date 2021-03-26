package models

import (
	"bee-shop-b2c/helpers"
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Product struct {
	Id                int              `orm:"column(id);auto" description:"主键_id"`
	Sn                string           `orm:"column(sn);size(100)" description:"编号"`
	Name              string           `orm:"column(name);size(255)" description:"名称"`
	Caption           string           `orm:"column(caption);size(255)" description:"副标题"`
	Image             string           `orm:"column(image);size(255);null" description:"展示图片"`
	Unit              string           `orm:"column(unit);size(255);null" description:"单位"`
	Weight            int              `orm:"column(weight);null" description:"重量"`
	Type              int              `orm:"column(type)" description:"类型"`
	IsMarketable      int8             `orm:"column(is_marketable)" description:"是否上架"`
	IsList            int8             `orm:"column(is_list)" description:"是否列出"`
	IsTop             int8             `orm:"column(is_top)" description:"是否置顶"`
	IsGift            int8             `orm:"column(is_gift)" description:"是否为赠品"`
	IsDelivery        int8             `orm:"column(is_delivery)" description:"是否需要物流"`
	Introduction      string           `orm:"column(introduction);null" description:"介绍"`
	Memo              string           `orm:"column(memo);size(255);null" description:"备注"`
	Keyword           string           `orm:"column(keyword);size(255);null" description:"搜索关键词"`
	SeoTitle          string           `orm:"column(seo_title);size(255);null" description:"页面标题"`
	SeoKeywords       string           `orm:"column(seo_keywords);size(255);null" description:"页面关键词"`
	SeoDescription    string           `orm:"column(seo_description);size(255);null" description:"页面描述"`
	Score             float32          `orm:"column(score)" description:"评分"`
	TotalScore        int64            `orm:"column(total_score)" description:"总评分"`
	ScoreCount        int64            `orm:"column(score_count)" description:"评分数"`
	Hits              int64            `orm:"column(hits)" description:"点击数"`
	WeekHits          int64            `orm:"column(week_hits)" description:"周点击数"`
	MonthHits         int64            `orm:"column(month_hits)" description:"月点击数"`
	Sales             int64            `orm:"column(sales)" description:"销量"`
	WeekSales         int64            `orm:"column(week_sales)" description:"周销量"`
	MonthSales        int64            `orm:"column(month_sales)" description:"月销量"`
	WeekHitsDate      time.Time        `orm:"column(week_hits_date);auto_now_add;type(datetime)" description:"周点击数更新日期"`
	MonthHitsDate     time.Time        `orm:"column(month_hits_date);auto_now_add;type(datetime)" description:"月点击数更新日期"`
	WeekSalesDate     time.Time        `orm:"column(week_sales_date);auto_now_add;type(datetime)" description:"周销量更新日期"`
	MonthSalesDate    time.Time        `orm:"column(month_sales_date);auto_now_add;type(datetime)" description:"月销量更新日期"`
	AttributeValue0   string           `orm:"column(attribute_value0);size(255);null" description:"商品属性值0"`
	AttributeValue1   string           `orm:"column(attribute_value1);size(255);null" description:"商品属性值1"`
	AttributeValue2   string           `orm:"column(attribute_value2);size(255);null" description:"商品属性值2"`
	AttributeValue3   string           `orm:"column(attribute_value3);size(255);null" description:"商品属性值3"`
	AttributeValue4   string           `orm:"column(attribute_value4);size(255);null" description:"商品属性值4"`
	AttributeValue5   string           `orm:"column(attribute_value5);size(255);null" description:"商品属性值5"`
	AttributeValue6   string           `orm:"column(attribute_value6);size(255);null" description:"商品属性值6"`
	AttributeValue7   string           `orm:"column(attribute_value7);size(255);null" description:"商品属性值7"`
	AttributeValue8   string           `orm:"column(attribute_value8);size(255);null" description:"商品属性值8"`
	AttributeValue9   string           `orm:"column(attribute_value9);size(255);null" description:"商品属性值9"`
	AttributeValue10  string           `orm:"column(attribute_value10);size(255);null" description:"商品属性值10"`
	AttributeValue11  string           `orm:"column(attribute_value11);size(255);null" description:"商品属性值11"`
	AttributeValue12  string           `orm:"column(attribute_value12);size(255);null" description:"商品属性值12"`
	AttributeValue13  string           `orm:"column(attribute_value13);size(255);null" description:"商品属性值13"`
	AttributeValue14  string           `orm:"column(attribute_value14);size(255);null" description:"商品属性值14"`
	AttributeValue15  string           `orm:"column(attribute_value15);size(255);null" description:"商品属性值15"`
	AttributeValue16  string           `orm:"column(attribute_value16);size(255);null" description:"商品属性值16"`
	AttributeValue17  string           `orm:"column(attribute_value17);size(255);null" description:"商品属性值17"`
	AttributeValue18  string           `orm:"column(attribute_value18);size(255);null" description:"商品属性值18"`
	AttributeValue19  string           `orm:"column(attribute_value19);size(255);null" description:"商品属性19"`
	BrandId           *Brand           `orm:"column(brand_id);rel(fk)" description:"品牌"`
	ProductCategoryId *ProductCategory `orm:"column(product_category_id);rel(fk)" description:"商品分类"`
	CreateBy          string           `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate      time.Time        `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy     string           `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate   time.Time        `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag        int8             `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Product) TableName() string {
	return "product"
}

func init() {
	orm.RegisterModel(new(Product))
}

// AddProduct insert a new Product into database and returns
// last inserted Id on success.
func AddProduct(m *Product) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetProductById retrieves Product by Id. Returns error if
// Id doesn't exist
func GetProductById(id int) (v *Product, err error) {
	o := orm.NewOrm()
	v = &Product{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetProductBySn retrieves Product by Sn. Returns error if
// Sn doesn't exist
func GetProductBySn(sn string) (v *Product, err error) {
	o := orm.NewOrm()
	v = &Product{Sn: sn}
	if err = o.Read(v, "Sn"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetProductCount calculate Product Count. Returns error if
// Table doesn't exist
func GetProductCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Product))
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

// GetAllProduct retrieves all Product matches certain condition. Returns empty list if
// no records exist
func GetAllProduct(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Product))
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

	var l []Product
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

/**
 * 只有需要联合查询
 */
func GetAllProductByOtherFiled(query map[string]string, offset int64, limit int64) (v []Product, err error) {
	o := orm.NewOrm()

	sql := "SELECT %v FROM `product` "
	fields := strings.Join(getFieldsWithProduct(), ", ")
	sql = fmt.Sprintf(sql, fields)
	dealSql, kv := dealWithQuery(sql, query)
	dealSql += strings.Join(kv, " ")
	dealSql += fmt.Sprintf(" LIMIT %v OFFSET %v", limit, offset)
	if num, err := o.Raw(dealSql).QueryRows(&v); err == nil && num > 0 {
		return v, nil
	}
	return nil, err
}

func getFieldsWithProduct() (fields []string) {
	fields = append(fields, "product.`id`")
	fields = append(fields, "product.`sn`")
	fields = append(fields, "product.`name`")
	fields = append(fields, "product.`caption`")
	fields = append(fields, "product.`image`")
	fields = append(fields, "product.`unit`")
	fields = append(fields, "product.`weight`")
	fields = append(fields, "product.`type`")
	fields = append(fields, "product.`is_marketable`")
	fields = append(fields, "product.`is_list`")
	fields = append(fields, "product.`is_top`")
	fields = append(fields, "product.`is_delivery`")
	fields = append(fields, "product.`is_gift`")
	fields = append(fields, "product.`introduction`")
	fields = append(fields, "product.`memo`")
	fields = append(fields, "product.`keyword`")
	fields = append(fields, "product.`seo_title`")
	fields = append(fields, "product.`seo_keywords`")
	fields = append(fields, "product.`seo_description`")
	fields = append(fields, "product.`attribute_value0`")
	fields = append(fields, "product.`attribute_value1`")
	fields = append(fields, "product.`attribute_value2`")
	fields = append(fields, "product.`attribute_value3`")
	fields = append(fields, "product.`attribute_value4`")
	fields = append(fields, "product.`attribute_value5`")
	fields = append(fields, "product.`attribute_value6`")
	fields = append(fields, "product.`attribute_value7`")
	fields = append(fields, "product.`attribute_value8`")
	fields = append(fields, "product.`attribute_value9`")
	fields = append(fields, "product.`attribute_value10`")
	fields = append(fields, "product.`attribute_value11`")
	fields = append(fields, "product.`attribute_value12`")
	fields = append(fields, "product.`attribute_value13`")
	fields = append(fields, "product.`attribute_value14`")
	fields = append(fields, "product.`attribute_value15`")
	fields = append(fields, "product.`attribute_value16`")
	fields = append(fields, "product.`attribute_value17`")
	fields = append(fields, "product.`attribute_value18`")
	fields = append(fields, "product.`attribute_value19`")
	fields = append(fields, "product.`brand_id`")
	fields = append(fields, "product.`product_category_id`")
	fields = append(fields, "product.`creation_date`")

	return fields
}

/**
 * 获取Product 联合查询的Count
 */
func GetProductByOtherFiled(query map[string]string) (count int64, err error) {
	o := orm.NewOrm()

	sql := "SELECT COUNT(*) as nums FROM `product` "
	dealSql, kv := dealWithQuery(sql, query)
	dealSql += strings.Join(kv, " ")
	if err := o.Raw(dealSql).QueryRow(&count); err == nil {
		return count, err
	}
	return 0, err
}

/**
 * 拼接关联查询SQL
 */
func dealWithQuery(sql string, query map[string]string) (dealSql string, whereKV []string) {
	dealQuery := make(map[string]string)
	for k, v := range query {
		if k == "DeleteFlag" {
			k = "Product.DeleteFlag"
		}
		dealQuery[k] = v
	}

	whereKV = append(whereKV, "WHERE ")
	if dealQuery["Stock__gt"] != "" {
		sql += "LEFT JOIN `sku` ON sku.`product_id` = product.`id` "
		whereKV = append(whereKV, "sku.`stock`")
		whereKV = append(whereKV, ">")
		whereKV = append(whereKV, "0")
		delete(dealQuery, "Stock__gt")
	}
	if dealQuery["Stock"] != "" {
		sql += "LEFT JOIN `sku` ON sku.`product_id` = product.`id` "
		whereKV = append(whereKV, "sku.`stock`")
		whereKV = append(whereKV, "=")
		whereKV = append(whereKV, "0")
		delete(dealQuery, "Stock")
	}
	if dealQuery["Tag"] != "" {
		sql += "LEFT JOIN `product_tag` ON product.`id` = product_tag.`products` "
		whereKV = append(whereKV, "product_tag.`tags`")
		whereKV = append(whereKV, "=")
		whereKV = append(whereKV, dealQuery["Tag"])
		if dealQuery["Promotions"] == "" {
			delete(dealQuery, "Tag")
		} else {
			whereKV = append(whereKV, "AND")
		}
	}
	if dealQuery["Promotions"] != "" {
		sql += "LEFT JOIN `promotion_product` ON product.`id` = promotion_product.`products` "
		whereKV = append(whereKV, "promotion_product.`promotions`")
		whereKV = append(whereKV, "=")
		whereKV = append(whereKV, dealQuery["Promotions"])
		delete(dealQuery, "Tag")
		delete(dealQuery, "Promotions")
	}
	/**
	 * 拼接 where 语句
	 */
	for k, v := range dealQuery {
		whereKV = append(whereKV, "AND")
		whereKV = append(whereKV, helpers.ToSnakeCase(k))
		whereKV = append(whereKV, "=")
		whereKV = append(whereKV, v)
	}
	dealSql = sql

	return dealSql, whereKV
}

// UpdateProduct updates Product by Id and returns error if
// the record to be updated doesn't exist
func UpdateProductById(m *Product) (err error) {
	o := orm.NewOrm()
	v := Product{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteProduct deletes Product by Id and returns error if
// the record to be deleted doesn't exist
func DeleteProduct(id int) (err error) {
	o := orm.NewOrm()
	v := Product{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Product{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

package models

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type Order struct {
	Id                 int        `orm:"column(id);auto" description:"主键_id"`
	Sn                 string     `orm:"column(sn);size(100)" description:"订单编号"`
	Status             int        `orm:"column(status)" description:"订单状态"`
	Amount             float64    `orm:"column(amount);digits(21);decimals(6)" description:"订单金额"`
	AmountPaid         float64    `orm:"column(amount_paid);digits(21);decimals(6)" description:"已付金额"`
	CouponDiscount     float64    `orm:"column(coupon_discount);digits(21);decimals(6)" description:"优惠券折扣"`
	OffsetAmount       float64    `orm:"column(offset_amount);digits(21);decimals(6)" description:"调整金额"`
	Price              float64    `orm:"column(price);digits(21);decimals(6)" description:"商品价格"`
	Fee                float64    `orm:"column(fee);digits(21);decimals(6)" description:"支付手续费"`
	Freight            float64    `orm:"column(freight);digits(21);decimals(6)" description:"运费"`
	RewardPoint        int64      `orm:"column(reward_point)" description:"赠送积分"`
	Consignee          string     `orm:"column(consignee);size(255)" description:"收货人"`
	AreaName           string     `orm:"column(area_name);size(255)" description:"地区名称"`
	Address            string     `orm:"column(address);size(255)" description:"地址"`
	ZipCode            string     `orm:"column(zip_code);size(255);null" description:"邮编"`
	Phone              string     `orm:"column(phone);size(255)" description:"电话"`
	ExchangePoint      int64      `orm:"column(exchange_point)" description:"兑换积分"`
	IsAllocatedStock   int8       `orm:"column(is_allocated_stock)" description:"是否已分配库存"`
	IsExchangePoint    int8       `orm:"column(is_exchange_point)" description:"是否已兑换积分"`
	IsUseCouponCode    int8       `orm:"column(is_use_coupon_code)" description:"是否已使用优惠码"`
	IsNotify           int8       `orm:"column(is_notify)" description:"是否通知"`
	InvoiceContent     string     `orm:"column(invoice_content);size(255);null" description:"发票内容"`
	InvoiceTitle       string     `orm:"column(invoice_title);size(255);null" description:"发票标题"`
	Tax                float64    `orm:"column(tax);digits(21);decimals(6)" description:"税金"`
	Memo               string     `orm:"column(memo);size(255);null" description:"附言"`
	PaymentMethodName  string     `orm:"column(payment_method_name);size(255);null" description:"支付方式名称"`
	PaymentMethodType  int        `orm:"column(payment_method_type);null" description:"支付方式类型"`
	PromotionName      string     `orm:"column(promotion_name);size(255);null" description:"促销名称"`
	PromotionDiscount  float64    `orm:"column(promotion_discount);digits(21);decimals(6)" description:"促销折扣"`
	Expire             *time.Time `orm:"column(expire);type(datetime);null" description:"到期时间"`
	LockKey            string     `orm:"column(lock_key);size(255);null" description:"锁定KEY"`
	LockExpire         time.Time  `orm:"column(lock_expire);type(datetime);null" description:"锁定到期时间"`
	Weight             int        `orm:"column(weight)" description:"重量"`
	Source             int        `orm:"column(source);null" description:"订单来源"`
	Type               int        `orm:"column(type)" description:"类型"`
	Quantity           int        `orm:"column(quantity)" description:"商品数量"`
	RefundAmount       float64    `orm:"column(refund_amount);digits(21);decimals(9)" description:"退款金额"`
	ReturnedQuantity   int        `orm:"column(returned_quantity)" description:"退款商品数量"`
	ShippedQuantity    int        `orm:"column(shipped_quantity)" description:"已发货数量"`
	ShippingMethodName string     `orm:"column(shipping_method_name);size(255);null" description:"配送方式名称"`
	ShippingDate       time.Time  `orm:"column(shipping_date);type(datetime);null" description:"配送时间"`
	PaymentMethodId    int64      `orm:"column(payment_method_id);null" description:"支付方式"`
	ShippingMethodId   int64      `orm:"column(shipping_method_id);null" description:"配送方式"`
	DeliveryCorpId     int64      `orm:"column(delivery_corp_id);null" description:"物流公司"`
	DeliveryCorpName   string     `orm:"column(delivery_corp_name);null" description:"物流公司名称"`
	OperatorId         int64      `orm:"column(operator_id);null" description:"操作员"`
	AreaId             int64      `orm:"column(area_id);null" description:"地区"`
	MemberId           int64      `orm:"column(member_id)" description:"会员"`
	CouponCodeId       int64      `orm:"column(coupon_code_id);null" description:"优惠码"`
	CompleteDate       time.Time  `orm:"column(complete_date);type(datetime);null" description:"完成日期"`
	CreateBy           string     `orm:"column(create_by);size(20);null" description:"创建人"`
	CreationDate       time.Time  `orm:"column(creation_date);auto_now_add;type(datetime);null" description:"创建日期"`
	LastUpdatedBy      string     `orm:"column(last_updated_by);size(20);null" description:"最后修改人"`
	LastUpdatedDate    time.Time  `orm:"column(last_updated_date);auto_now;type(datetime);null" description:"最后修改日期"`
	DeleteFlag         int8       `orm:"column(delete_flag)" description:"删除标记"`
}

func (t *Order) TableName() string {
	return "order"
}

func init() {
	orm.RegisterModel(new(Order))
}

// AddOrder insert a new Order into database and returns
// last inserted Id on success.
func AddOrder(m *Order) (id int64, err error) {
	o := orm.NewOrm()
	id, err = o.Insert(m)
	return
}

// GetOrderById retrieves Order by Id. Returns error if
// Id doesn't exist
func GetOrderById(id int) (v *Order, err error) {
	o := orm.NewOrm()
	v = &Order{Id: id}
	if err = o.Read(v); err == nil {
		return v, nil
	}
	return nil, err
}

// GetOrderBySn retrieves Order by Sn. Returns error if
// Sn doesn't exist
func GetOrderBySn(sn string) (v *Order, err error) {
	o := orm.NewOrm()
	v = &Order{Sn: sn}
	if err = o.Read(v, "Sn"); err == nil {
		return v, nil
	}
	return nil, err
}

// GetOrderCount calculate Order Count. Returns error if
// Table doesn't exist
func GetOrderCount(query map[string]string) (cnt int64, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Order))
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

/**
 * 查询 无需退款的订单 Count
 */
func GetOrderNoRefundCount() (count int64, err error) {
	o := orm.NewOrm()
	sql := "SELECT COUNT(*) as nums FROM `order` WHERE `status` IN (0, 6, 7, 8, 11)"

	if err := o.Raw(sql).QueryRow(&count); err == nil {
		return count, nil
	}
	return 0, err
}

/**
 * 查询 无需退款订单
 * pendingPayment 0
 * failed 6
 * canceled 7
 * denied 8
 * refunded 11
 */
func GetNoRefundOrder(offset int64, limit int64) (ml []Order, err error) {
	o := orm.NewOrm()
	sql := "SELECT * FROM `order` WHERE `status` IN (0, 6, 7, 8, 11) LIMIT %v OFFSET %v"

	sql = fmt.Sprintf(sql, limit, offset)

	if _, err = o.Raw(sql).QueryRows(&ml); err == nil {
		return ml, nil
	}
	return nil, err
}

// GetAllOrder retrieves all Order matches certain condition. Returns empty list if
// no records exist
func GetAllOrder(query map[string]string, fields []string, sortby []string, order []string,
	offset int64, limit int64) (ml []interface{}, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable(new(Order))
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

	var l []Order
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

// UpdateOrder updates Order by Id and returns error if
// the record to be updated doesn't exist
func UpdateOrderById(m *Order) (err error) {
	o := orm.NewOrm()
	v := Order{Id: m.Id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Update(m); err == nil {
			fmt.Println("Number of records updated in database:", num)
		}
	}
	return
}

// DeleteOrder deletes Order by Id and returns error if
// the record to be deleted doesn't exist
func DeleteOrder(id int) (err error) {
	o := orm.NewOrm()
	v := Order{Id: id}
	// ascertain id exists in the database
	if err = o.Read(&v); err == nil {
		var num int64
		if num, err = o.Delete(&Order{Id: id}); err == nil {
			fmt.Println("Number of records deleted in database:", num)
		}
	}
	return
}

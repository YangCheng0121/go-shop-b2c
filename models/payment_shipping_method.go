package models

import "github.com/astaxie/beego/orm"

type PaymentShippingMethod struct {
	PaymentMethods  int `orm:"column(payment_methods);rel(fk)"`
	ShippingMethods int `orm:"column(shipping_methods);rel(fk)"`
}

func AddPaymentShippingMethods(paymentMethods int, shippingMethods int) (err error) {
	o := orm.NewOrm()
	sql := "INSERT INTO `payment_shipping_method` (`payment_methods`, `shipping_methods`) VALUES (?, ?)"
	_, err = o.Raw(sql, paymentMethods, shippingMethods).Exec()
	return
}

func GetPaymentShippingMethodsByShippingMethods(shippingMethods int) (ml []*PaymentShippingMethod, err error) {
	o := orm.NewOrm()
	sql := "SELECT `payment_methods`,`shipping_methods` FROM payment_shipping_method WHERE shipping_methods = ?"
	if num, err := o.Raw(sql, shippingMethods).QueryRows(&ml); num > 0 && err == nil {
		return ml, nil
	}
	return nil, err
}

func DeletePaymentShippingMethods(paymentMethods int, shippingMethods int) (err error) {
	o := orm.NewOrm()
	sql := "DELETE FROM payment_shipping_method WHERE payment_methods = ? AND shipping_methods = ?"
	_, err = o.Raw(sql, paymentMethods, shippingMethods).Exec()
	return
}

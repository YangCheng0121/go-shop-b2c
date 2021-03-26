package payment

const (
	/**
	 * 款到发货
	 */
	deliveryAgainstPayment = iota
	/**
	 * 货到付款
	 */
	cashOnDelivery
)

/**
 * 获取支付类型名称
 */
func GetPaymentMethodTypeName(typeInt int) string {
	switch typeInt {
	case deliveryAgainstPayment:
		return "款到发货"
	case cashOnDelivery:
		return "货到付款"
	default:
		return ""
	}
}

/**
 * 通过别名获取支付类型
 */
func GetPaymentMethodTypeByAlias(alias string) int {
	switch alias {
	case "deliveryAgainstPayment":
		return deliveryAgainstPayment
	case "cashOnDelivery":
		return cashOnDelivery
	default:
		return -1
	}
}

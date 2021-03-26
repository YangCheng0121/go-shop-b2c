package payment

const (
	/**
	 * 线上支付 0
	 */
	online = iota
	/**
	 * 线下支付 1
	 */
	offline
	/**
	 * 预存款支付 2
	 */
	deposit
)

/**
 * 获取支付方式名称
 */
func GetPaymentMethodName(methodInt int) string {
	switch methodInt {
	case online:
		return "在线支付"
	case offline:
		return "线下支付"
	case deposit:
		return "预存款支付"
	default:
		return ""
	}
}

/**
 * 获取支付方式
 */
func GetPaymentMethodByAlias(name string) int {
	switch name {
	case "online":
		return online
	case "offline":
		return offline
	case "deposit":
		return deposit
	default:
		return -1
	}
}

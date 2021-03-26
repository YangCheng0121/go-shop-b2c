package order

const (
	/**
	 * 普通订单 0
	 */
	general = iota
	/*
	 * 兑换订单 1
	 */
	exchange
	/*
	 * 积分订单 2
	 */
	point
)

/**
 * 获取订单类型的名称
 */
func GetOrderTypeName(status int) string {
	switch status {
	case general:
		return "general"
	case exchange:
		return "exchange"
	case point:
		return "point"
	default:
		return ""
	}
}

/**
 * 根据订单类型别名 获取订单类型
 */
func GetOrderTypeByName(name string) int {
	switch name {
	case "general":
		return general
	case "exchange":
		return exchange
	case "point":
		return point
	default:
		return -1
	}
}

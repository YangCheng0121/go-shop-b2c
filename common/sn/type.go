package sn

const (
	/*
	 * 商品
	 */
	product = iota
	/*
	 * 订单
	 */
	order
	/*
	 * 支付
	 */
	payment
	/*
	 * 发货
	 */
	ship
	/*
	 * 退货
	 */
	returns
	/*
	 * 退款
	 */
	refunds
)

/**
 * 获取 Sn 类型 -1 表示未找到
 */
func GetSnTypeByAlias(typeStr string) int {
	switch typeStr {
	case "product":
		return product
	case "order":
		return order
	case "payment":
		return payment
	case "ship":
		return ship
	case "returns":
		return returns
	case "refunds":
		return refunds
	default:
		return -1
	}
}

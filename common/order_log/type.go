package order_log

const (
	/**
	 * 订单创建 0
	 */
	create = iota

	/**
	 * 订单修改 1
	 */
	modify

	/**
	 * 订单取消 2
	 */
	cancel

	/**
	 * 订单审核 3
	 */
	review

	/**
	 * 订单收款 4
	 */
	payment

	/**
	 * 订单退款 5
	 */
	refunds

	/**
	 * 订单发货 6
	 */
	ship

	/**
	 * 订单退货 7
	 */
	returns

	/**
	 * 订单收货 8
	 */
	receive

	/**
	 * 订单完成 9
	 */
	complete

	/**
	 * 订单失败 10
	 */
	fail
)

/**
 * 获取订单记录类型名称
 */
func GetOrderLogTypeName(typeInt int) string {
	switch typeInt {
	case create:
		return "订单创建"
	case modify:
		return "订单修改"
	case cancel:
		return "订单取消"
	case review:
		return "订单审核"
	case payment:
		return "订单支付"
	case refunds:
		return "订单退款"
	case ship:
		return "订单发货"
	case returns:
		return "订单退货"
	case receive:
		return "订单收货"
	case complete:
		return "订单完成"
	case fail:
		return "订单失败"
	default:
		return ""
	}
}

/**
 * 通过别名获取订单记录类型
 */
func GetOrderLogTypeNameByAlias(aliasName string) string {
	switch aliasName {
	case "create":
		return "订单创建"
	case "modify":
		return "订单修改"
	case "cancel":
		return "订单取消"
	case "review":
		return "订单审核"
	case "payment":
		return "订单支付"
	case "refunds":
		return "订单退款"
	case "ship":
		return "订单发货"
	case "returns":
		return "订单退货"
	case "receive":
		return "订单收货"
	case "complete":
		return "订单完成"
	case "fail":
		return "订单失败"
	default:
		return ""
	}
}

/**
 * 通过别名获取订单记录类型
 */
func GetOrderLogTypeByAlias(aliasName string) int {
	switch aliasName {
	case "create":
		return create
	case "modify":
		return modify
	case "cancel":
		return cancel
	case "review":
		return review
	case "payment":
		return payment
	case "refunds":
		return refunds
	case "ship":
		return ship
	case "returns":
		return returns
	case "receive":
		return receive
	case "complete":
		return complete
	case "fail":
		return fail
	default:
		return -1
	}
}

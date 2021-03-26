package order

const (
	/**
	 * 等待付款 0
	 */
	pendingPayment = iota
	/**
	 * 等待审核 1
	 */
	pendingReview
	/**
	 * 等待发货 2
	 */
	pendingShipment
	/**
	 * 已发货 3
	 */
	shipped
	/**
	 * 已收货 4
	 */
	received
	/*
	 * 已完成 5
	 */
	completed
	/*
	 * 已失败 6
	 */
	failed
	/*
	 * 已取消 7
	 */
	canceled
	/*
	 * 已拒绝 8
	 */
	denied
	/**
	 * 已退货 9
	 */
	returns
	/*
	 * 未完成 10
	 */
	unfinished
	/*
	 * 退款中 11
	 */
	refunding
	/*
	 * 退款完成 12
	 */
	refunded
)

/**
 * 获取订单状态名称
 */
func GetOrderStatusName(status int) string {
	switch status {
	case pendingPayment:
		return "等待付款"
	case pendingReview:
		return "等待审核"
	case pendingShipment:
		return "等待发货"
	case shipped:
		return "已发货"
	case received:
		return "已收货"
	case completed:
		return "已完成"
	case failed:
		return "已失败"
	case canceled:
		return "已取消"
	case denied:
		return "已拒绝"
	case returns:
		return "已退货"
	case unfinished:
		return "未完成"
	case refunding:
		return "退款中"
	case refunded:
		return "退款完成"
	default:
		return ""
	}
}

/**
 * 获取订单状态别名
 */
func GetOrderStatusAliasName(status int) string {
	switch status {
	case pendingPayment:
		return "pendingPayment"
	case pendingReview:
		return "pendingReview"
	case pendingShipment:
		return "pendingShipment"
	case shipped:
		return "shipped"
	case received:
		return "received"
	case completed:
		return "completed"
	case failed:
		return "failed"
	case canceled:
		return "canceled"
	case denied:
		return "denied"
	case returns:
		return "returns"
	case unfinished:
		return "unfinished"
	case refunding:
		return "refunding"
	case refunded:
		return "refunded"
	default:
		return ""
	}
}

/**
 * 根据订单状态别名 获取订单状态
 */
func GetOrderStatusByAlias(name string) int {
	switch name {
	case "pendingPayment":
		return pendingPayment
	case "pendingReview":
		return pendingReview
	case "pendingShipment":
		return pendingShipment
	case "shipped":
		return shipped
	case "received":
		return received
	case "completed":
		return completed
	case "failed":
		return failed
	case "canceled":
		return canceled
	case "denied":
		return denied
	case "returns":
		return returns
	case "unfinished":
		return unfinished
	case "refunding":
		return refunding
	case "refunded":
		return refunded
	default:
		return -1
	}
}

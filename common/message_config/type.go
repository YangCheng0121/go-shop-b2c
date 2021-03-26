package message_config

const (
	/**
	 * 订单失败
	 */
	orderFail = iota
	/**
	 * 订单完整
	 */
	orderComplete
	/**
	 * 订单收货
	 */
	orderReceive
	/**
	 * 订单退货
	 */
	orderReturn
	/**
	 * 订单发货
	 */
	orderShip
	/**
	 * 订单退款
	 */
	orderRefund
	/**
	 * 订单收款
	 */
	orderPay
	/**
	 * 订单审核
	 */
	orderReview
	/**
	 * 订单取消
	 */
	orderCancel
	/**
	 * 订单
	 */
	orderUpdate
	/**
	 * 订单创建
	 */
	orderCreate
	/**
	 * 会员注册
	 */
	memberRegister
)

/**
 * 获取消息配置名称
 */
func GetMessageTypeName(status int) string {
	switch status {
	case orderFail:
		return "订单失败"
	case orderComplete:
		return "订单完成"
	case orderReceive:
		return "订单收货"
	case orderReturn:
		return "订单退货"
	case orderShip:
		return "订单发货"
	case orderRefund:
		return "订单退款"
	case orderPay:
		return "订单收款"
	case orderReview:
		return "订单审核"
	case orderCancel:
		return "订单取消"
	case orderUpdate:
		return "订单更新"
	case orderCreate:
		return "订单创建"
	case memberRegister:
		return "会员创建"
	default:
		return ""
	}
}

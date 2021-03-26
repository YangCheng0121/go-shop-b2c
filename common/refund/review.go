package refund

const (
	// 拒绝
	reject = iota
	// 通过
	allow
)

/**
 * 获取退款审核状态
 */
func GetRefundReviewByAlias(alias string) int8 {
	switch alias {
	case "reject":
		return reject
	case "allow":
		return allow
	default:
		return -1
	}
}

package payment

const (
	/**
	 * 成功 0
	 */
	Fail = iota
	/**
	 * 失败 1
	 */
	Success
)

/**
 * 获取支付方式名称
 */
func GetPaymentStatusByAlias(status string) int {
	switch status {
	case "fail":
		return Fail
	case "success":
		return Success
	default:
		return -1
	}
}

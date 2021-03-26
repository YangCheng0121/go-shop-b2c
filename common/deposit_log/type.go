package deposit_log

const (
	/**
	 *  预存款充值
	 */
	recharge = iota
	/**
	 * 预存款提现
	 */
	withdraw
)

/**
 * 通过别名获取预存款类型
 */
func GetDepositLogTypeByAlias(alias string) int {
	switch alias {
	case "recharge":
		return recharge
	case "withdraw":
		return withdraw
	default:
		return -1
	}
}

/**
 * 获取预存款类型名称
 */
func GetDepositLogName(i int) string {
	switch i {
	case recharge:
		return "预存款充值"
	case withdraw:
		return "预存款提现"
	default:
		return ""
	}
}

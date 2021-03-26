package point_log

const (
	/*
	 * 积分赠送
	 */
	giveAway = iota
	/*
	 * 积分扣除
	 */
	deduction
)

/**
 * 通过别名获取积分记录类型
 */
func GetPointLogTypeByAlias(alias string) int {
	switch alias {
	case "giveAway":
		return giveAway
	case "deduction":
		return deduction
	default:
		return -1
	}
}

/**
 * 获取积分类型名称
 */
func GetPointLogName(i int) string {
	switch i {
	case giveAway:
		return "积分赠送"
	case deduction:
		return "积分扣除"
	default:
		return ""
	}
}

package sms

const (
	sms = iota
)

/**
 * 通过别名获取类型
 */
func GetSmsTypeByAlias(alias string) int {
	switch alias {
	case "sms":
		return sms
	default:
		return -1
	}
}

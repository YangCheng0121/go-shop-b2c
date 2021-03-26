package plugin

const (
	/**
	 * 存储
	 */
	storage = iota
	/**
	 * 登录
	 */
	login
	/**
	 * 支付
	 */
	payment
)

/**
 * 通过别名获取插件类型
 */
func GetPluginTypeByAlias(alias string) int {
	switch alias {
	case "storage":
		return storage
	case "login":
		return login
	case "payment":
		return payment
	default:
		return -1
	}
}

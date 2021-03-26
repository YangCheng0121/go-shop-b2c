package product

const (
	/*
	 * 普通商品 0
	 */
	general = iota
	/*
	 * 兑换商品 1
	 */
	exchange
	/*
	 * 赠品 2
	 */
	gift
)

/**
 * 获取商品类型, -1 表示未找到
 */
func GetProductTypeByAlias(alias string) int {
	switch alias {
	case "general":
		return general
	case "exchange":
		return exchange
	case "gift":
		return gift
	default:
		return -1
	}
}

/**
 * 获取商品类型名称
 */
func GetProductTypeName(i int) string {
	switch i {
	case general:
		return "general"
	case exchange:
		return "exchange"
	case gift:
		return "gift"
	default:
		return ""
	}
}

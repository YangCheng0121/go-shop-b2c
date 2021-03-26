package stock

const (
	/**
	 * 入库 0
	 */
	in = iota
	/**
	 * 出库 1
	 */
	out
)

/**
 * 获取库存类型, -1 表示未找到
 */
func GetStockTypeByAlias(s string) int {
	switch s {
	case "in":
		return in
	case "out":
		return out
	default:
		return -1
	}
}

/**
 * 获取库存类型名称
 */
func GetStockTypeByAliasName(i int) string {
	switch i {
	case in:
		return "in"
	case out:
		return "out"
	default:
		return ""
	}
}

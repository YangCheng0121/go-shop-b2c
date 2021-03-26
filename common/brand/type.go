package brand

const (
	/**
	 * 文本 0
	 */
	text = iota
	/**
	 * 图片 1
	 */
	image
)

/**
 * 通过别名获取品牌类型
 */
func GetBrandTypeByAlias(alias string) int {
	switch alias {
	case "text":
		return text
	case "image":
		return image
	default:
		return -1
	}
}

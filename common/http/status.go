package http

const (
	ok                  = 200
	created             = 201
	forbidden           = 403
	internalServerError = 500
)

/**
 * 获取标准的 HTTP 状态码, -1 表示未找到
 */
func GetHttpStatusByAlias(s string) int {
	switch s {
	case "ok":
		return ok
	case "created":
		return created
	case "forbidden":
		return forbidden
	case "internalServerError":
		return internalServerError
	default:
		return -1
	}
}

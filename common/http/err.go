package http

/**
 * err code
 */
const (
	/*
	 * 失败
	 */
	ErrError = 0
	/*
	 * 成功
	 */
	ErrOK = 1
	/**
	 * 登录状态失效
	 */
	UNAUTHORIZED = 401
)

/**
 * err message
 */
const (
	Success = "success"
	Fail    = "fail"
)

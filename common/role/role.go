package role

/**
 * 用户权限
 */
const (
	// 超级管理员
	RAdmin = 1
	// 普通管理员
	RManager = 2
	// 普通会员
	RMember = 3
)

func GetRoleByAlias(role string) int64 {
	switch role {
	case "R_ADMIN":
		return RAdmin
	case "R_MANAGER":
		return RManager
	case "R_MEMBER":
		return RMember
	default:
		return RMember
	}
}

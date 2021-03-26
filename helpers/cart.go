package helpers

import uuid "github.com/satori/go.uuid"

/**
 * 生成 CartKey UID + MD5
 */
func GenerateCartKey() (cartKey string) {
	uidStr := uuid.Must(uuid.NewV4(), nil).String()
	md5Str := GetMd5String(uidStr)

	return uidStr + "-" + md5Str
}

package helpers

import (
	"crypto/hmac"
	"crypto/md5"
	"crypto/sha256"
	"encoding/hex"
	"regexp"
	"strings"
)

var matchAllCap = regexp.MustCompile("([a-z0-9])([A-Z])")

func ToSnakeCase(str string) string {
	snake := matchAllCap.ReplaceAllString(str, "${1}_${2}")
	return strings.ToLower(snake)
}

// 32返回一个32位md5加密后的字符串
func GetMd5String(data string) string {
	h := md5.New()
	h.Write([]byte(data))
	return hex.EncodeToString(h.Sum(nil))
}

// 返回一个16位md5加密后的字符串
func Get16Md5String(data string) string {
	return GetMd5String(data)[8:24]
}

// key随意设置 data 要加密数据
func Hmac(key, data string) string {
	hash := hmac.New(md5.New, []byte(key)) // 创建对应的md5哈希加密算法
	hash.Write([]byte(data))
	return hex.EncodeToString(hash.Sum([]byte("")))
}

func HmacSha256(key, data string) string {
	hash := hmac.New(sha256.New, []byte(key)) // 创建对应的sha256哈希加密算法
	hash.Write([]byte(data))
	return hex.EncodeToString(hash.Sum([]byte("")))
}

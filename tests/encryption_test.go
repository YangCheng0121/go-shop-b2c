package tests

import (
	"crypto/hmac"
	"crypto/md5"
	"crypto/sha1"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"go-shop-b2c/helpers"
	"strconv"
	"testing"
)

// 这是一个悲剧
func TestEncryption(t *testing.T) {
	node, _ := helpers.NewWorker(0)
	sn := strconv.FormatInt(node.GetId(), 10)

	md5Str := GetMd5String(sn)
	fmt.Println("MD5:" + md5Str)

	hmacStr := Hmac(sn, sn)
	fmt.Println("Hmac:" + hmacStr)

	hmacSha256Str := HmacSha256(sn, sn)
	fmt.Println("HmacSha256:" + hmacSha256Str)

	shaStr := Sha1(sn)
	fmt.Println("Sha1:" + shaStr)

}

func GetMd5String(s string) string {
	h := md5.New()
	h.Write([]byte(s))
	return hex.EncodeToString(h.Sum(nil))
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

func Sha1(data string) string {
	hash := sha1.New()
	hash.Write([]byte(data))
	return hex.EncodeToString(hash.Sum([]byte("")))
}

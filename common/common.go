package common

import "github.com/astaxie/beego"

// session
const SessionName = "__beeShopB2C_session__"

// app_key
func AppKey() string {
	return beego.AppConfig.DefaultString("app_key", "beeShopB2C")
}

// api_key
func GetApiKey() string {
	return beego.AppConfig.DefaultString("api_ca", "./xxxx.p12")
}

// 正则表达式
const RegexpEmail = `^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$`

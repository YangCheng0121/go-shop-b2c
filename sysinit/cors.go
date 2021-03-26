package sysinit

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/plugins/cors"
)

func corsInit() {
	beego.InsertFilter("*", beego.BeforeRouter, cors.Allow(&cors.Options{
		// 可选参数"GET", "POST", "PUT", "DELETE", "OPTIONS" (*为所有)
		// 其中Options跨域复杂请求预检
		AllowMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		// 指的是允许的Header的种类
		AllowHeaders: []string{"Origin", "Authorization", "Access-Control-Allow-Origin", "Access-Control-Allow-Headers", "Content-Type"},
		// 公开的HTTP标头列表
		ExposeHeaders: []string{"Content-Length", "Access-Control-Allow-Origin", "Access-Control-Allow-Headers", "Content-Type"},
		// 如果设置，则允许共享身份验证凭据，例如cookie
		AllowCredentials: true,
		// 指定可访问域名AllowOrigins
		AllowOrigins: []string{"*"},
	}))
}

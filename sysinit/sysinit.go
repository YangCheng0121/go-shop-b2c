package sysinit

import (
	"bee-shop-b2c/models"
	"encoding/gob"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
)

func sysInit() {
	if beego.AppConfig.String("runmode") != "prod" {
		/**
		 * 打印当前环境
		 */
		runmode := beego.AppConfig.String("runmode")
		logs.Info("runmode:", runmode)
		/**
		 * 打印数据链接地址
		 */
		logs.Info("Mysql Connection:", beego.AppConfig.String("sqlconn"))
		/**
		 * 设置静态文件目录
		 */
		beego.SetStaticPath("/static", "static")
	}
	/**
	 * 序列化Admin、Member对象,必须在encoding/gob编码解码前进行注册
	 */
	gob.Register(models.Admin{})
	gob.Register(models.Member{})
}

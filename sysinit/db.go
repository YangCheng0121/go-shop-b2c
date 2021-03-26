package sysinit

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

func dbInit() {
	/**
	 * 打印SQL语句
	 */
	orm.Debug = true
	_ = orm.RegisterDataBase("default", "mysql", beego.AppConfig.String("sqlconn"))
}

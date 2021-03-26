package sysinit

import (
	"github.com/astaxie/beego/logs"
)

func logsInit() {
	_ = logs.SetLogger("console")
	logs.EnableFuncCallDepth(true)
}

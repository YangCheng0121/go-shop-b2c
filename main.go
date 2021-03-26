package main

import (
	_ "bee-shop-b2c/routers"
	_ "bee-shop-b2c/sysinit"
	"github.com/astaxie/beego"
)

func main() {
	beego.Run()
}

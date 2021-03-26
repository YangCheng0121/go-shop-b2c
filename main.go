package main

import (
	"github.com/astaxie/beego"
	_ "go-shop-b2c/routers"
	_ "go-shop-b2c/sysinit"
)

func main() {
	beego.Run()
}

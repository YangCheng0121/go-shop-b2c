package redis

import (
	"github.com/astaxie/beego"
	"github.com/silenceper/wechat/v2/cache"
)

func GetRedis() *cache.Redis {
	redisOpts := &cache.RedisOpts{
		Host:        beego.AppConfig.String("redisHost"),     // redis host
		Password:    beego.AppConfig.String("redisPassword"), // redis password
		Database:    0,                                       // redis db
		MaxActive:   10,                                      // 连接池最大活跃连接数
		MaxIdle:     10,                                      // 连接池最大空闲连接数
		IdleTimeout: 60,                                      // 空闲连接超时时间，单位：second
	}
	redisCache := cache.NewRedis(redisOpts)
	return redisCache
}

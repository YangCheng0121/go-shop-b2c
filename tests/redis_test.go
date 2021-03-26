package tests

import (
	"github.com/astaxie/beego/logs"
	"github.com/silenceper/wechat/v2/cache"
	"testing"
)

func TestRedis(t *testing.T) {
	redisOpts := &cache.RedisOpts{
		Host:        "127.0.0.1:6379", // redis host
		Password:    "123456",         // redis password
		Database:    0,                // redis db
		MaxActive:   10,               // 连接池最大活跃连接数
		MaxIdle:     10,               // 连接池最大空闲连接数
		IdleTimeout: 60,               // 空闲连接超时时间，单位：second
	}
	redisCache := cache.NewRedis(redisOpts)
	logs.Info("redisCache:", &redisCache)
}

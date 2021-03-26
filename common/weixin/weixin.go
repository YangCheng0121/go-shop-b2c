package weixin

import (
	"github.com/silenceper/wechat/v2"
	"github.com/silenceper/wechat/v2/officialaccount"
	wechatOfficialConfig "github.com/silenceper/wechat/v2/officialaccount/config"
	"github.com/silenceper/wechat/v2/pay"
	wechatPayConfig "github.com/silenceper/wechat/v2/pay/config"
	"github.com/silenceper/wechat/v2/pay/notify"
	"github.com/silenceper/wechat/v2/pay/refund"
	"go-shop-b2c/common/redis"
	"strconv"
)

type config struct {
	AppID     string
	AppSecret string
	MchID     string
	Key       string
	NotifyURL string
}

/**
 * 获取配置
 */
func GetConfig() *config {
	config := &config{
		AppID:     "wx257bce1251b43eaf",
		AppSecret: "e687a13bb013b227e95d640affae1856",
		MchID:     "1606299989",
		Key:       "MDE0MTZkYWNlOGY1YzE2ODU0Y2Y4YTU4",
		NotifyURL: "https://www.mifengfeng.com/api/web/notify/payment",
	}
	return config
}

/**
 * 获取公众号实例
 */
func GetOfficialAccount() *officialaccount.OfficialAccount {
	wc := wechat.NewWechat()
	// 这里本地内存保存access_token，也可选择redis，memcache或者自定cache
	cache := redis.GetRedis()
	config := GetConfig()
	cfg := &wechatOfficialConfig.Config{
		AppID:     config.AppID,
		AppSecret: config.AppSecret,
		// EncodingAESKey: "xxxx",
		Cache: cache,
	}
	return wc.GetOfficialAccount(cfg)
}

/**
 * 获取支付实例
 */
func GetPay() *pay.Pay {
	wc := wechat.NewWechat()
	// 这里本地内存保存access_token，也可选择redis，memcache或者自定cache
	config := GetConfig()
	cfg := &wechatPayConfig.Config{
		AppID:     config.AppID,
		MchID:     config.MchID,
		Key:       config.Key,
		NotifyURL: config.NotifyURL,
	}

	return wc.GetPay(cfg)
}

/**
 * 获取支付通知实例
 */
func GetPayNotify() *notify.Notify {
	return GetPay().GetNotify()
}

/**
 * 获取支付退款实例
 */
func GetPayRefund() *refund.Refund {
	return GetPay().GetRefund()
}

/**
 * 获取支付 总金额
 * 单位为分
 */
func GetTotalFree(amount float64) string {
	totalFree := int64(amount * 100)
	return strconv.FormatInt(totalFree, 10)
}

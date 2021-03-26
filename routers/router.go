// @APIVersion 1.0.0
// @Title beego Test API
// @Description beego has a very cool tools to autogenerate documents for your API
// @Contact astaxie@gmail.com
// @TermsOfServiceUrl http://beego.me/
// @License Apache 2.0
// @LicenseUrl http://www.apache.org/licenses/LICENSE-2.0.html
package routers

import (
	"github.com/astaxie/beego"
	"go-shop-b2c/controllers/admin"
	"go-shop-b2c/controllers/web"
)

func init() {
	adminRoute := beego.NewNamespace("/api/admin",

		beego.NSNamespace("/admin",
			beego.NSInclude(
				&admin.AdminController{},
			),
		),

		beego.NSNamespace("/attribute",
			beego.NSInclude(
				&admin.AttributeController{},
			),
		),

		beego.NSNamespace("/brand",
			beego.NSInclude(
				&admin.BrandController{},
			),
		),

		beego.NSNamespace("/order",
			beego.NSInclude(
				&admin.OrderController{},
			),
		),

		beego.NSNamespace("/parameter",
			beego.NSInclude(
				&admin.ParameterController{},
			),
		),

		beego.NSNamespace("/product",
			beego.NSInclude(
				&admin.ProductController{},
			),
		),

		beego.NSNamespace("/product_category",
			beego.NSInclude(
				&admin.ProductCategoryController{},
			),
		),

		beego.NSNamespace("/product_notify",
			beego.NSInclude(
				&admin.ProductNotify{},
			),
		),

		beego.NSNamespace("/promotion",
			beego.NSInclude(
				&admin.PromotionController{},
			),
		),

		beego.NSNamespace("/specification",
			beego.NSInclude(
				&admin.SpecificationController{},
			),
		),

		beego.NSNamespace("/tag",
			beego.NSInclude(
				&admin.TagController{},
				&admin.TagController{},
			),
		),

		beego.NSNamespace("/upload",
			beego.NSInclude(
				&admin.UploadController{},
			),
		),

		beego.NSNamespace("/setting",
			beego.NSInclude(
				&admin.SettingController{},
			),
		),

		beego.NSNamespace("/sku",
			beego.NSInclude(
				&admin.SkuController{},
			),
		),

		beego.NSNamespace("/stock",
			beego.NSInclude(
				&admin.StockController{},
			),
		),

		beego.NSNamespace("/payment_method",
			beego.NSInclude(
				&admin.PaymentMethodController{},
			),
		),

		beego.NSNamespace("/delivery_corp",
			beego.NSInclude(
				&admin.DeliveryCorpController{},
			),
		),

		beego.NSNamespace("/area",
			beego.NSInclude(
				&admin.AreaController{},
			),
		),

		beego.NSNamespace("/user",
			beego.NSInclude(
				&admin.UserController{},
			),
		),

		beego.NSNamespace("/shipping_method",
			beego.NSInclude(
				&admin.ShippingMethodController{},
			),
		),

		beego.NSNamespace("/area_freight_config",
			beego.NSInclude(
				&admin.AreaFreightConfigController{},
			),
		),

		beego.NSNamespace("/plugin_config",
			beego.NSInclude(
				&admin.PluginConfigController{},
			),
		),

		beego.NSNamespace("/role",
			beego.NSInclude(
				&admin.RoleController{},
			),
		),

		beego.NSNamespace("/permission",
			beego.NSInclude(
				&admin.PermissionController{},
			),
		),

		beego.NSNamespace("/payment",
			beego.NSInclude(
				&admin.PaymentController{},
			),
		),

		beego.NSNamespace("/refunds",
			beego.NSInclude(
				&admin.RefundsController{},
			),
		),

		beego.NSNamespace("/shipping",
			beego.NSInclude(
				&admin.ShippingController{},
			),
		),

		beego.NSNamespace("/returns",
			beego.NSInclude(
				&admin.ReturnsController{},
			),
		),

		beego.NSNamespace("/delivery_center",
			beego.NSInclude(
				&admin.DeliveryCenterController{},
			),
		),

		beego.NSNamespace("/member_rank",
			beego.NSInclude(
				&admin.MemberRankController{},
			),
		),

		beego.NSNamespace("/point_log",
			beego.NSInclude(
				&admin.PointLogController{},
			),
		),

		beego.NSNamespace("/deposit_log",
			beego.NSInclude(
				&admin.DepositLogController{},
			),
		),

		beego.NSNamespace("/member",
			beego.NSInclude(
				&admin.MemberController{},
			),
		),

		beego.NSNamespace("/review",
			beego.NSInclude(
				&admin.ReviewController{},
			),
		),

		beego.NSNamespace("/consultation",
			beego.NSInclude(
				&admin.ConsultationController{},
			),
		),

		beego.NSNamespace("/message_config",
			beego.NSInclude(
				&admin.MessageConfigController{},
			),
		),

		beego.NSNamespace("/coupon",
			beego.NSInclude(
				&admin.CouponController{},
			),
		),

		beego.NSNamespace("/ad",
			beego.NSInclude(
				&admin.AdController{},
			),
		),
	)

	webRoute := beego.NewNamespace("/api/web",
		beego.NSNamespace("/index",
			beego.NSInclude(
				&web.IndexController{},
			),
		),

		beego.NSNamespace("/product",
			beego.NSInclude(
				&web.ProductController{},
			),
		),

		beego.NSNamespace("/category",
			beego.NSInclude(
				&web.CategoryController{},
			),
		),

		beego.NSNamespace("/shopcart",
			beego.NSInclude(
				&web.ShopCartController{},
			),
		),

		beego.NSNamespace("/search",
			beego.NSInclude(
				&web.SearchController{},
			),
		),

		beego.NSNamespace("/order",
			beego.NSInclude(
				&web.OrderController{},
			),
		),

		beego.NSNamespace("/coupon",
			beego.NSInclude(
				&web.CouponController{},
			),
		),

		beego.NSNamespace("/sms",
			beego.NSInclude(
				&web.SmsController{},
			),
		),

		beego.NSNamespace("/user",
			beego.NSInclude(
				&web.UserController{},
			),
		),

		beego.NSNamespace("/address",
			beego.NSInclude(
				&web.AddressController{},
			),
		),

		beego.NSNamespace("/area",
			beego.NSInclude(
				&web.AreaController{},
			),
		),

		beego.NSNamespace("/wechat",
			beego.NSInclude(
				&web.WeChatController{},
			),
		),

		beego.NSNamespace("/payment",
			beego.NSInclude(
				&web.PaymentController{},
			),
		),

		beego.NSNamespace("/notify",
			beego.NSRouter(
				"/payment",
				&web.NotifyController{},
				"*:NotifyPayment",
			),
		),
	)

	/**
	 * 注册路由
	 */
	beego.AddNamespace(adminRoute)
	beego.AddNamespace(webRoute)
}

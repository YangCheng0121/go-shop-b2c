package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context/param"
)

func init() {

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"],
		beego.ControllerComments{
			Method:           "GetAllAddress",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"],
		beego.ControllerComments{
			Method:           "GetAddress",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"],
		beego.ControllerComments{
			Method:           "AddAddress",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"],
		beego.ControllerComments{
			Method:           "DeleteAddress",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AddressController"],
		beego.ControllerComments{
			Method:           "UpdateAddress",
			Router:           "/update",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AreaController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:AreaController"],
		beego.ControllerComments{
			Method:           "GetAllArea",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CategoryController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CategoryController"],
		beego.ControllerComments{
			Method:           "GetRoot",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CategoryController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CategoryController"],
		beego.ControllerComments{
			Method:           "GetChildren",
			Router:           "/children",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CouponController"],
		beego.ControllerComments{
			Method:           "GetAllCoupon",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:CouponController"],
		beego.ControllerComments{
			Method:           "ExchangeCoupon",
			Router:           "/exchange",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:IndexController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:IndexController"],
		beego.ControllerComments{
			Method:           "GetData",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:IndexController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:IndexController"],
		beego.ControllerComments{
			Method:           "GetBanner",
			Router:           "/banner",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:NotifyController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:NotifyController"],
		beego.ControllerComments{
			Method:           "NotifyPayment",
			Router:           "/payment",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "GetAllOrder",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "GetOrder",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "AddOrder",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "CancelOrder",
			Router:           "/cancel",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "CheckoutOrder",
			Router:           "/checkout",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "GetOrderCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "GetOrderCoupon",
			Router:           "/coupon",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "GetAllPaymentMethod",
			Router:           "/payment_method",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "RefundOrder",
			Router:           "/refund",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "GetAllShippingMethod",
			Router:           "/shipping_method",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:OrderController"],
		beego.ControllerComments{
			Method:           "UpdateOrder",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:PaymentController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:PaymentController"],
		beego.ControllerComments{
			Method:           "Payment",
			Router:           "/payment",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"],
		beego.ControllerComments{
			Method:           "GetAllProduct",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"],
		beego.ControllerComments{
			Method:           "GetProduct",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"],
		beego.ControllerComments{
			Method:           "GetAllProductReview",
			Router:           "/review",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ProductController"],
		beego.ControllerComments{
			Method:           "GetAllSelectSpecification",
			Router:           "/specification/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:SearchController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:SearchController"],
		beego.ControllerComments{
			Method:           "Search",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:SearchController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:SearchController"],
		beego.ControllerComments{
			Method:           "HotSearch",
			Router:           "/hot",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"],
		beego.ControllerComments{
			Method:           "GetShopCartItems",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"],
		beego.ControllerComments{
			Method:           "AddShopCartItem",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"],
		beego.ControllerComments{
			Method:           "GetShopCartCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"],
		beego.ControllerComments{
			Method:           "DeleteShopCartItem",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:ShopCartController"],
		beego.ControllerComments{
			Method:           "UpdateShopCartItem",
			Router:           "/update",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:SmsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:SmsController"],
		beego.ControllerComments{
			Method:           "GetSms",
			Router:           "/",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:UserController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:UserController"],
		beego.ControllerComments{
			Method:           "Login",
			Router:           "/login",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:UserController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:UserController"],
		beego.ControllerComments{
			Method:           "Logout",
			Router:           "/logout",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:WeChatController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:WeChatController"],
		beego.ControllerComments{
			Method:           "GetAuthorizedCode",
			Router:           "/authorized-code",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:WeChatController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/web:WeChatController"],
		beego.ControllerComments{
			Method:           "AuthorizedLogin",
			Router:           "/authorized-login",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

}

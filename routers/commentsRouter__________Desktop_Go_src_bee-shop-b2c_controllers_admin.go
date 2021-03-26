package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context/param"
)

func init() {

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"],
		beego.ControllerComments{
			Method:           "GetAllAd",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"],
		beego.ControllerComments{
			Method:           "GetAd",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"],
		beego.ControllerComments{
			Method:           "GetAllAdPosition",
			Router:           "/ad_position",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"],
		beego.ControllerComments{
			Method:           "AddAd",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"],
		beego.ControllerComments{
			Method:           "DeleteAd",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdController"],
		beego.ControllerComments{
			Method:           "UpdateAd",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"],
		beego.ControllerComments{
			Method:           "GetAllAdmin",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"],
		beego.ControllerComments{
			Method:           "GetAdmin",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"],
		beego.ControllerComments{
			Method:           "AddAdmin",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"],
		beego.ControllerComments{
			Method:           "DeleteAdmin",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AdminController"],
		beego.ControllerComments{
			Method:           "UpdateAdmin",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"],
		beego.ControllerComments{
			Method:           "GetAllArea",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"],
		beego.ControllerComments{
			Method:           "GetArea",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"],
		beego.ControllerComments{
			Method:           "AddArea",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"],
		beego.ControllerComments{
			Method:           "GetAreaCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"],
		beego.ControllerComments{
			Method:           "DeleteArea",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaController"],
		beego.ControllerComments{
			Method:           "UpdateArea",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"],
		beego.ControllerComments{
			Method:           "GetAllAreaFreightConfig",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"],
		beego.ControllerComments{
			Method:           "GetAreaFreightConfig",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"],
		beego.ControllerComments{
			Method:           "AddAreaFreightConfig",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"],
		beego.ControllerComments{
			Method:           "GetAreaFreightConfigCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"],
		beego.ControllerComments{
			Method:           "DeleteAreaFreightConfig",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AreaFreightConfigController"],
		beego.ControllerComments{
			Method:           "UpdateAreaFreightConfig",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"],
		beego.ControllerComments{
			Method:           "GetAllAttribute",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"],
		beego.ControllerComments{
			Method:           "GetAttribute",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"],
		beego.ControllerComments{
			Method:           "AddAttribute",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"],
		beego.ControllerComments{
			Method:           "DeleteAttribute",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:AttributeController"],
		beego.ControllerComments{
			Method:           "UpdateAttribute",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"],
		beego.ControllerComments{
			Method:           "GetAllBrand",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"],
		beego.ControllerComments{
			Method:           "GetBrand",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"],
		beego.ControllerComments{
			Method:           "AddBrand",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"],
		beego.ControllerComments{
			Method:           "GetBrandCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"],
		beego.ControllerComments{
			Method:           "DeleteBrand",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:BrandController"],
		beego.ControllerComments{
			Method:           "UpdateBrand",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"],
		beego.ControllerComments{
			Method:           "GetAllConsultation",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"],
		beego.ControllerComments{
			Method:           "GetConsultation",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"],
		beego.ControllerComments{
			Method:           "UpdateConsultationIsShow",
			Router:           "/toggle/is_show",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ConsultationController"],
		beego.ControllerComments{
			Method:           "UpdateConsultation",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "GetAllCoupon",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "GetCoupon",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "AddCoupon",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "GetCouponCodeCount",
			Router:           "/code/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "GenerateCouponCode",
			Router:           "/code/generate",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "GetCouponCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "DeleteCoupon",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:CouponController"],
		beego.ControllerComments{
			Method:           "UpdateCoupon",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"],
		beego.ControllerComments{
			Method:           "GetAllDeliveryCenter",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"],
		beego.ControllerComments{
			Method:           "GetDeliveryCenter",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"],
		beego.ControllerComments{
			Method:           "AddDeliveryCenter",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"],
		beego.ControllerComments{
			Method:           "GeDeliveryCenterCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"],
		beego.ControllerComments{
			Method:           "DeleteDeliveryCenter",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCenterController"],
		beego.ControllerComments{
			Method:           "UpdateDeliveryCenter",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"],
		beego.ControllerComments{
			Method:           "GetAllDeliveryCorp",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"],
		beego.ControllerComments{
			Method:           "GetDeliveryCorp",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"],
		beego.ControllerComments{
			Method:           "AddDeliveryCorp",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"],
		beego.ControllerComments{
			Method:           "GeDeliveryCorpCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"],
		beego.ControllerComments{
			Method:           "DeleteDeliveryCorp",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DeliveryCorpController"],
		beego.ControllerComments{
			Method:           "UpdateDeliveryCorp",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DepositLogController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DepositLogController"],
		beego.ControllerComments{
			Method:           "GetAllDepositLog",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DepositLogController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DepositLogController"],
		beego.ControllerComments{
			Method:           "GetDepositLog",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DepositLogController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:DepositLogController"],
		beego.ControllerComments{
			Method:           "AddDepositLog",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"],
		beego.ControllerComments{
			Method:           "GetAllMember",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"],
		beego.ControllerComments{
			Method:           "GetMember",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"],
		beego.ControllerComments{
			Method:           "AddMember",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"],
		beego.ControllerComments{
			Method:           "DeleteMember",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberController"],
		beego.ControllerComments{
			Method:           "UpdateMember",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"],
		beego.ControllerComments{
			Method:           "GetAllMemberRank",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"],
		beego.ControllerComments{
			Method:           "GetMemberRank",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"],
		beego.ControllerComments{
			Method:           "AddMemberRank",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"],
		beego.ControllerComments{
			Method:           "GetMemberRankCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"],
		beego.ControllerComments{
			Method:           "DeleteMemberRank",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MemberRankController"],
		beego.ControllerComments{
			Method:           "UpdateMemberRank",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MessageConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MessageConfigController"],
		beego.ControllerComments{
			Method:           "GetAllMessageConfig",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MessageConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MessageConfigController"],
		beego.ControllerComments{
			Method:           "GetMessageConfig",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MessageConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:MessageConfigController"],
		beego.ControllerComments{
			Method:           "UpdateMessageConfig",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "GetAllOrder",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "GetOneOrder",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "CompleteOrder",
			Router:           "/complete",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "DeleteOrder",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "FailOrder",
			Router:           "/fail",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "GetOrderItems",
			Router:           "/items",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "GetLogs",
			Router:           "/logs",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "GetProducts",
			Router:           "/products",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "ReceivePayment",
			Router:           "/receive_payment",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "ReviewOrder",
			Router:           "/review",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "ShipOrder",
			Router:           "/ship",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:OrderController"],
		beego.ControllerComments{
			Method:           "UpdateOrder",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"],
		beego.ControllerComments{
			Method:           "GetAllParameter",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"],
		beego.ControllerComments{
			Method:           "GetParameter",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"],
		beego.ControllerComments{
			Method:           "AddParameter",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"],
		beego.ControllerComments{
			Method:           "DeleteParameter",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ParameterController"],
		beego.ControllerComments{
			Method:           "UpdateParameter",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentController"],
		beego.ControllerComments{
			Method:           "GetAllPayment",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentController"],
		beego.ControllerComments{
			Method:           "GetOnePayment",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentController"],
		beego.ControllerComments{
			Method:           "GetPaymentByOrder",
			Router:           "/order",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"],
		beego.ControllerComments{
			Method:           "GetAllPaymentMethod",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"],
		beego.ControllerComments{
			Method:           "GetPaymentMethod",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"],
		beego.ControllerComments{
			Method:           "AddPaymentMethod",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"],
		beego.ControllerComments{
			Method:           "GetPaymentMethodCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"],
		beego.ControllerComments{
			Method:           "DeletePaymentMethod",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PaymentMethodController"],
		beego.ControllerComments{
			Method:           "UpdatePaymentMethod",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PermissionController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PermissionController"],
		beego.ControllerComments{
			Method:           "GetAllPermission",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"],
		beego.ControllerComments{
			Method:           "GetAllPluginConfig",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"],
		beego.ControllerComments{
			Method:           "GetPluginConfig",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"],
		beego.ControllerComments{
			Method:           "AddPluginConfig",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"],
		beego.ControllerComments{
			Method:           "GePluginConfigCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"],
		beego.ControllerComments{
			Method:           "DeletePluginConfig",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PluginConfigController"],
		beego.ControllerComments{
			Method:           "UpdatePluginConfig",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PointLogController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PointLogController"],
		beego.ControllerComments{
			Method:           "GetAllPointLog",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PointLogController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PointLogController"],
		beego.ControllerComments{
			Method:           "GetPointLog",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PointLogController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PointLogController"],
		beego.ControllerComments{
			Method:           "AddPointLog",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"],
		beego.ControllerComments{
			Method:           "GetAllProductCategory",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"],
		beego.ControllerComments{
			Method:           "GetProductCategory",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"],
		beego.ControllerComments{
			Method:           "AddProductCategory",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"],
		beego.ControllerComments{
			Method:           "DeleteProductCategory",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductCategoryController"],
		beego.ControllerComments{
			Method:           "UpdateProductCategory",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "GetAllProduct",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "GetOneProduct",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "AddProduct",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "GetProductAttributes",
			Router:           "/attributes",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "GetProductCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "DeleteProduct",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "GetProductParameters",
			Router:           "/parameters",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "GetProductSpecifications",
			Router:           "/specifications",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "UpdateProduct",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductController"],
		beego.ControllerComments{
			Method:           "ToggleMarketableProduct",
			Router:           "/update/marketable",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductNotify"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ProductNotify"],
		beego.ControllerComments{
			Method:           "GetAllProductNotify",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"],
		beego.ControllerComments{
			Method:           "GetAllPromotion",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"],
		beego.ControllerComments{
			Method:           "GetPromotion",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"],
		beego.ControllerComments{
			Method:           "AddPromotion",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"],
		beego.ControllerComments{
			Method:           "GetPromotionCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"],
		beego.ControllerComments{
			Method:           "DeletePromotion",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:PromotionController"],
		beego.ControllerComments{
			Method:           "UpdatePromotion",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"],
		beego.ControllerComments{
			Method:           "GetAllRefunds",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"],
		beego.ControllerComments{
			Method:           "GetOneRefunds",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"],
		beego.ControllerComments{
			Method:           "GetRefundsByOrder",
			Router:           "/order",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RefundsController"],
		beego.ControllerComments{
			Method:           "ReviewRefund",
			Router:           "/review",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReturnsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReturnsController"],
		beego.ControllerComments{
			Method:           "GetAllReturns",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReturnsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReturnsController"],
		beego.ControllerComments{
			Method:           "GetOneReturns",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReturnsController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReturnsController"],
		beego.ControllerComments{
			Method:           "GetReturnsByOrder",
			Router:           "/order",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"],
		beego.ControllerComments{
			Method:           "GetAllReview",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"],
		beego.ControllerComments{
			Method:           "GetReview",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"],
		beego.ControllerComments{
			Method:           "UpdateReviewIsShow",
			Router:           "/toggle/is_show",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ReviewController"],
		beego.ControllerComments{
			Method:           "UpdateReview",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"],
		beego.ControllerComments{
			Method:           "GetAllRole",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"],
		beego.ControllerComments{
			Method:           "GetRole",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"],
		beego.ControllerComments{
			Method:           "AddRole",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"],
		beego.ControllerComments{
			Method:           "GetRoleCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"],
		beego.ControllerComments{
			Method:           "DeleteRole",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:RoleController"],
		beego.ControllerComments{
			Method:           "UpdateRole",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SettingController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SettingController"],
		beego.ControllerComments{
			Method:           "GetAllSetting",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SettingController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SettingController"],
		beego.ControllerComments{
			Method:           "UpdateSetting",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingController"],
		beego.ControllerComments{
			Method:           "GetAllShipping",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingController"],
		beego.ControllerComments{
			Method:           "GetOneShipping",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingController"],
		beego.ControllerComments{
			Method:           "GetShippingByOrder",
			Router:           "/order",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"],
		beego.ControllerComments{
			Method:           "GetAllShippingMethod",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"],
		beego.ControllerComments{
			Method:           "GetShippingMethod",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"],
		beego.ControllerComments{
			Method:           "AddShippingMethod",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"],
		beego.ControllerComments{
			Method:           "GetShippingMethodCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"],
		beego.ControllerComments{
			Method:           "DeleteShippingMethod",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:ShippingMethodController"],
		beego.ControllerComments{
			Method:           "UpdateShippingMethod",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SkuController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SkuController"],
		beego.ControllerComments{
			Method:           "GetAllSku",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SkuController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SkuController"],
		beego.ControllerComments{
			Method:           "GetSku",
			Router:           "/:sn",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"],
		beego.ControllerComments{
			Method:           "GetAllSpecification",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"],
		beego.ControllerComments{
			Method:           "GetSpecification",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"],
		beego.ControllerComments{
			Method:           "AddSpecification",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"],
		beego.ControllerComments{
			Method:           "DeleteSpecification",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:SpecificationController"],
		beego.ControllerComments{
			Method:           "UpdateSpecification",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:StockController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:StockController"],
		beego.ControllerComments{
			Method:           "InStock",
			Router:           "/in",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:StockController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:StockController"],
		beego.ControllerComments{
			Method:           "GetAllStock",
			Router:           "/log",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:StockController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:StockController"],
		beego.ControllerComments{
			Method:           "OutStock",
			Router:           "/out",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"],
		beego.ControllerComments{
			Method:           "GetAllTag",
			Router:           "/",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"],
		beego.ControllerComments{
			Method:           "GetTag",
			Router:           "/:id",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"],
		beego.ControllerComments{
			Method:           "AddTag",
			Router:           "/add",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"],
		beego.ControllerComments{
			Method:           "GetTagListTotalCount",
			Router:           "/count",
			AllowHTTPMethods: []string{"get"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"],
		beego.ControllerComments{
			Method:           "DeleteTag",
			Router:           "/delete",
			AllowHTTPMethods: []string{"delete"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:TagController"],
		beego.ControllerComments{
			Method:           "UpdateTag",
			Router:           "/update",
			AllowHTTPMethods: []string{"put"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:UploadController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:UploadController"],
		beego.ControllerComments{
			Method:           "Upload",
			Router:           "/",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:UserController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:UserController"],
		beego.ControllerComments{
			Method:           "Login",
			Router:           "/login",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

	beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:UserController"] = append(beego.GlobalControllerRouter["bee-shop-b2c/controllers/admin:UserController"],
		beego.ControllerComments{
			Method:           "Register",
			Router:           "/register",
			AllowHTTPMethods: []string{"post"},
			MethodParams:     param.Make(),
			Filters:          nil,
			Params:           nil})

}

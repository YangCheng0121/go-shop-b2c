package admin

import (
	"encoding/json"
	"github.com/astaxie/beego/utils"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type ShippingMethodController struct {
	BaseController
}

// URLMapping ...
func (c *ShippingMethodController) URLMapping() {
	c.Mapping("DeleteShippingMethod", c.DeleteShippingMethod)
	c.Mapping("UpdateShippingMethod", c.UpdateShippingMethod)
	c.Mapping("GetShippingMethod", c.GetShippingMethod)
	c.Mapping("GetShippingMethodCount", c.GetShippingMethodCount)
	c.Mapping("GetAllShippingMethod", c.GetAllShippingMethod)
}

// @router /add [post]
func (c *ShippingMethodController) AddShippingMethod() {
	var shippingMethod model_views.ShippingMethod

	if v := c.GetString("shipping_method"); v != "" {
		_ = json.Unmarshal([]byte(v), &shippingMethod)
	}

	var shippingMethodModel models.ShippingMethod

	shippingMethodModel.Name = shippingMethod.Name
	shippingMethodModel.DefaultDeliveryCorpId = &models.DeliveryCorp{Id: shippingMethod.DefaultDeliveryCorpId}
	shippingMethodModel.Description = shippingMethod.Description
	shippingMethodModel.Icon = shippingMethod.Icon
	shippingMethodModel.FirstPrice = shippingMethod.FirstPrice
	shippingMethodModel.FirstWeight = shippingMethod.FirstWeight
	shippingMethodModel.ContinuePrice = shippingMethod.ContinuePrice
	shippingMethodModel.ContinueWeight = shippingMethod.ContinueWeight

	id, err := models.AddShippingMethod(&shippingMethodModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 添加关联支持支付方式
	 */
	for _, paymentMethod := range shippingMethod.PaymentShippingMethods {
		err = models.AddPaymentShippingMethods(paymentMethod, int(id))
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete ShippingMethod
// @router /delete [delete]
func (c *ShippingMethodController) DeleteShippingMethod() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, id := range ids {
		id, _ := strconv.Atoi(id)
		shippingMethod, err := models.GetShippingMethodById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		/**
		 * 删除关联支持支付方式
		 */
		paymentShippingMethods, err := models.GetPaymentShippingMethodsByShippingMethods(shippingMethod.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		for _, method := range paymentShippingMethods {
			err = models.DeletePaymentShippingMethods(method.PaymentMethods, method.ShippingMethods)
			if err != nil {
				c.ServerError(err)
				return
			}
		}

		shippingMethod.LastUpdatedBy = c.Admin.Name
		err = models.UpdateShippingMethodById(shippingMethod)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Shipping Method
// @router /update [put]
func (c *ShippingMethodController) UpdateShippingMethod() {
	var shippingMethod model_views.ShippingMethod

	if v := c.GetString("shipping_method"); v != "" {
		_ = json.Unmarshal([]byte(v), &shippingMethod)
	}

	shippingMethodModel, err := models.GetShippingMethodById(shippingMethod.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	shippingMethodModel.Name = shippingMethod.Name
	shippingMethodModel.DefaultDeliveryCorpId = &models.DeliveryCorp{Id: shippingMethod.DefaultDeliveryCorpId}
	shippingMethodModel.Description = shippingMethod.Description
	shippingMethodModel.Icon = shippingMethod.Icon
	shippingMethodModel.FirstPrice = shippingMethod.FirstPrice
	shippingMethodModel.FirstWeight = shippingMethod.FirstWeight
	shippingMethodModel.ContinuePrice = shippingMethod.ContinuePrice
	shippingMethodModel.ContinueWeight = shippingMethod.ContinueWeight
	shippingMethodModel.Orders = shippingMethod.Orders

	var paymentShippingMethodsStr []string
	var nextPaymentShippingMethodsStr []string

	paymentShippingMethods, err := models.GetPaymentShippingMethodsByShippingMethods(shippingMethodModel.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * paymentShippingMethodsStr
	 */
	for _, v := range paymentShippingMethods {
		str := strconv.Itoa(v.PaymentMethods)
		paymentShippingMethodsStr = append(paymentShippingMethodsStr, str)
	}
	/**
	 * nextPaymentShippingMethodsStr
	 */
	for _, v := range shippingMethod.PaymentShippingMethods {
		str := strconv.Itoa(v)
		nextPaymentShippingMethodsStr = append(nextPaymentShippingMethodsStr, str)
	}

	/**
	 * 新增 payment_shipping_method 关联
	 */
	for _, v := range nextPaymentShippingMethodsStr {
		if in := utils.InSlice(v, paymentShippingMethodsStr); in == false {
			paymentMethod, _ := strconv.Atoi(v)
			err = models.AddPaymentShippingMethods(paymentMethod, shippingMethod.Id)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除 payment_shipping_method 关联
	 */
	for _, v := range paymentShippingMethodsStr {
		if in := utils.InSlice(v, nextPaymentShippingMethodsStr); in == false {
			paymentMethod, _ := strconv.Atoi(v)
			err = models.DeletePaymentShippingMethods(paymentMethod, shippingMethod.Id)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	shippingMethodModel.LastUpdatedBy = c.Admin.Name
	err = models.UpdateShippingMethodById(shippingMethodModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get One ShippingMethod
// @router /:id
func (c *ShippingMethodController) GetShippingMethod() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	shippingMethod, err := models.GetShippingMethodById(id)
	if err != nil {
		c.ServerError(err)
		return
	}

	shippingView := c.setShippingMethodByShippingMethodView(*shippingMethod)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, shippingView)
}

// @Title Get ShippingMethod Count
// @router /count
func (c *ShippingMethodController) GetShippingMethodCount() {
	var query = make(map[string]string)
	// query: k:v,k:v
	if v := c.GetString("query"); v != "" {
		for _, cond := range strings.Split(v, ",") {
			kv := strings.SplitN(cond, ":", 2)
			if len(kv) != 2 {
				c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, "fail", "Error: invalid query key/value pair")
				return
			}
			k, v := kv[0], kv[1]
			query[k] = v
		}
	}

	query["DeleteFlag"] = "0"
	cnt, err := models.GetShippingMethodCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get All ShippingMethod
// @router / [get]
func (c *ShippingMethodController) GetAllShippingMethod() {
	var sortby []string
	var order []string
	var query = make(map[string]string)
	var pageSize int64 = 10
	var pageNumber int64 = 1

	// sortby: col1,col2
	if v := c.GetString("sortby"); v != "" {
		sortby = strings.Split(v, ",")
	}
	// order: desc,asc
	if v := c.GetString("order"); v != "" {
		order = strings.Split(v, ",")
	}
	// query: k:v,k:v
	if v := c.GetString("query"); v != "" {
		for _, cond := range strings.Split(v, ",") {
			kv := strings.SplitN(cond, ":", 2)
			if len(kv) != 2 {
				c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, "fail", "Error: invalid query key/value pair")
				return
			}
			k, v := kv[0], kv[1]
			query[k] = v
		}
	}
	// pageNumber: 1 (default is 1)
	if v := c.GetString("pageNumber"); v != "" {
		pageNumber, _ = strconv.ParseInt(v, 10, 64)
	}
	// pageSize: 10 (default is 10)
	if v := c.GetString("pageSize"); v != "" {
		pageSize, _ = strconv.ParseInt(v, 10, 64)
	}

	// start position of result set
	offset := (pageNumber - 1) * pageSize

	query["DeleteFlag"] = "0"
	l, err := models.GetAllShippingMethod(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		shippingMethod := v.(models.ShippingMethod)
		shippingMethodView := c.setShippingMethodByShippingMethodView(shippingMethod)

		pageList = append(pageList, shippingMethodView)
	}

	cnt, err := models.GetShippingMethodCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, *pages)
}

/**
 * ShippingMethodModel 转为 ShippingMethodView
 */
func (c *ShippingMethodController) setShippingMethodByShippingMethodView(shippingMethod models.ShippingMethod) (shippingMethodView model_views.ShippingMethod) {
	shippingMethodView.Id = shippingMethod.Id
	shippingMethodView.Name = shippingMethod.Name
	shippingMethodView.Orders = shippingMethod.Orders
	shippingMethodView.FirstWeight = shippingMethod.FirstWeight
	shippingMethodView.FirstPrice = shippingMethod.FirstPrice
	shippingMethodView.ContinuePrice = shippingMethod.ContinuePrice
	shippingMethodView.ContinueWeight = shippingMethod.ContinueWeight
	shippingMethodView.Icon = shippingMethod.Icon
	shippingMethodView.Description = shippingMethod.Description
	shippingMethodView.DefaultDeliveryCorpId = shippingMethod.DefaultDeliveryCorpId.Id
	paymentShippingMethods, err := models.GetPaymentShippingMethodsByShippingMethods(shippingMethod.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, paymentShippingMethod := range paymentShippingMethods {
		shippingMethodView.PaymentShippingMethods = append(shippingMethodView.PaymentShippingMethods, paymentShippingMethod.PaymentMethods)
	}

	return shippingMethodView
}

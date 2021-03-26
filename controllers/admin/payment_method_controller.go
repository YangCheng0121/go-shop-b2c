package admin

import (
	"bee-shop-b2c/common/http"
	paymentHelper "bee-shop-b2c/common/payment"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"encoding/json"
	"strconv"
	"strings"
)

type PaymentMethodController struct {
	BaseController
}

// URLMapping ...
func (c *PaymentMethodController) URLMapping() {
	c.Mapping("AddPaymentMethod", c.AddPaymentMethod)
	c.Mapping("DeletePaymentMethod", c.DeletePaymentMethod)
	c.Mapping("UpdatePaymentMethod", c.UpdatePaymentMethod)
	c.Mapping("GetPaymentMethodCount", c.GetPaymentMethodCount)
	c.Mapping("GetAllPaymentMethod", c.GetAllPaymentMethod)
}

// @Title Add PaymentMethod
// @router /add [post]
func (c *PaymentMethodController) AddPaymentMethod() {
	var paymentMethod model_views.PaymentMethod

	if v := c.GetString("payment_method"); v != "" {
		_ = json.Unmarshal([]byte(v), &paymentMethod)
	}

	var paymentMethodModel models.PaymentMethod
	paymentMethodModel.Name = paymentMethod.Name
	paymentMethodModel.Orders = paymentMethod.Orders
	paymentMethodModel.Icon = paymentMethod.Icon
	paymentMethodModel.Description = paymentMethod.Description
	paymentMethodModel.Type = paymentMethod.Type
	paymentMethodModel.Timeout = paymentMethod.Timeout
	paymentMethodModel.Content = paymentMethod.Content
	paymentMethodModel.Method = paymentMethod.Method
	paymentMethodModel.CreateBy = c.Admin.Name

	_, err := models.AddPaymentMethod(&paymentMethodModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete PaymentMethod
// @router /delete [delete]
func (c *PaymentMethodController) DeletePaymentMethod() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		paymentMethod, err := models.GetPaymentMethodById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		paymentMethod.LastUpdatedBy = c.Admin.Name
		paymentMethod.DeleteFlag = 1

		err = models.UpdatePaymentMethodById(paymentMethod)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update PaymentMethod
// @router /update [put]
func (c *PaymentMethodController) UpdatePaymentMethod() {
	var paymentMethod model_views.PaymentMethod

	if v := c.GetString("payment_method"); v != "" {
		_ = json.Unmarshal([]byte(v), &paymentMethod)
	}

	paymentMethodModel, err := models.GetPaymentMethodById(paymentMethod.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	paymentMethodModel.Name = paymentMethod.Name
	paymentMethodModel.Orders = paymentMethod.Orders
	paymentMethodModel.Icon = paymentMethod.Icon
	paymentMethodModel.Description = paymentMethod.Description
	paymentMethodModel.Type = paymentMethod.Type
	paymentMethodModel.Timeout = paymentMethod.Timeout
	paymentMethodModel.Content = paymentMethod.Content
	paymentMethodModel.Method = paymentMethod.Method
	paymentMethodModel.LastUpdatedBy = c.Admin.Name

	err = models.UpdatePaymentMethodById(paymentMethodModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get PaymentMethod
// @router /:id [get]
func (c *PaymentMethodController) GetPaymentMethod() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	paymentMethod, err := models.GetPaymentMethodById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	paymentMethodView := c.setPaymentMethodByPaymentMethodModel(*paymentMethod)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, paymentMethodView)
}

// Get PaymentMethod Count
// @router /count [get]
func (c *PaymentMethodController) GetPaymentMethodCount() {
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
	cnt, err := models.GetPaymentMethodCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get All PaymentMethod
// @router / [get]
func (c *PaymentMethodController) GetAllPaymentMethod() {
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
	cnt, err := models.GetPaymentMethodCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllPaymentMethod(query, nil, sortby, order, offset, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		paymentMethod := v.(models.PaymentMethod)
		paymentMethodView := c.setPaymentMethodByPaymentMethodModel(paymentMethod)
		pageList = append(pageList, paymentMethodView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

/**
 * PaymentMethodModel 转为 PaymentMethodView
 */
func (c *PaymentMethodController) setPaymentMethodByPaymentMethodModel(paymentMethod models.PaymentMethod) (paymentMethodView model_views.PaymentMethod) {
	paymentMethodView.Id = paymentMethod.Id
	paymentMethodView.Name = paymentMethod.Name
	paymentMethodView.Orders = paymentMethod.Orders
	paymentMethodView.Icon = paymentMethod.Icon
	paymentMethodView.Description = paymentMethod.Description
	paymentMethodView.Type = paymentMethod.Type
	paymentMethodView.TypeName = paymentHelper.GetPaymentMethodTypeName(paymentMethod.Type)
	paymentMethodView.Timeout = paymentMethod.Timeout
	paymentMethodView.Content = paymentMethod.Content
	paymentMethodView.Method = paymentMethod.Method
	paymentMethodView.MethodName = paymentHelper.GetPaymentMethodName(paymentMethod.Method)

	return paymentMethodView
}

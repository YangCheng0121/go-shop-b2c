package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type CouponController struct {
	BaseController
}

// URLMapping ...
func (c *CouponController) URLMapping() {
	c.Mapping("AddCoupon", c.AddCoupon)
	c.Mapping("DeleteCoupon", c.DeleteCoupon)
	c.Mapping("UpdateCoupon", c.UpdateCoupon)
	c.Mapping("GetCoupon", c.GetCoupon)
	c.Mapping("GetCouponCount", c.GetCouponCount)
	c.Mapping("GetCouponCodeCount", c.GetCouponCodeCount)
	c.Mapping("GenerateCouponCode", c.GenerateCouponCode)
	c.Mapping("GetAllCoupon", c.GetAllCoupon)
}

// @Title Add Coupon
// @router /add [post]
func (c *CouponController) AddCoupon() {
	var coupon model_views.Coupon

	// coupon
	if v := c.GetString("coupon"); v != "" {
		_ = json.Unmarshal([]byte(v), &coupon)
	}

	var couponModel models.Coupon
	couponModel.Id = coupon.Id
	couponModel.Name = coupon.Name
	couponModel.Point = coupon.Point
	couponModel.IsEnabled = coupon.IsEnabled
	couponModel.PriceExpression = coupon.PriceExpression
	couponModel.MinimumQuantity = coupon.MinimumQuantity
	couponModel.MinimumPrice = coupon.MinimumPrice
	couponModel.MaximumQuantity = coupon.MaximumQuantity
	couponModel.MaximumPrice = coupon.MaximumPrice
	couponModel.EndDate = coupon.EndDate
	couponModel.BeginDate = coupon.BeginDate
	couponModel.Introduction = coupon.Introduction
	couponModel.IsExchange = coupon.IsExchange
	couponModel.Prefix = coupon.Prefix
	couponModel.Condition = coupon.Condition

	_, err := models.AddCoupon(&couponModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Coupon
// @router /delete [delete]
func (c *CouponController) DeleteCoupon() {
	var ids []string

	// ids
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		err := models.DeleteCoupon(id)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Coupon
// @router /update [put]
func (c *CouponController) UpdateCoupon() {
	var coupon model_views.Coupon

	// coupon
	if v := c.GetString("coupon"); v != "" {
		_ = json.Unmarshal([]byte(v), &coupon)
	}

	couponModel, err := models.GetCouponById(coupon.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	couponModel.Id = coupon.Id
	couponModel.Name = coupon.Name
	couponModel.Point = coupon.Point
	couponModel.IsEnabled = coupon.IsEnabled
	couponModel.PriceExpression = coupon.PriceExpression
	couponModel.MinimumQuantity = coupon.MinimumQuantity
	couponModel.MinimumPrice = coupon.MinimumPrice
	couponModel.MaximumQuantity = coupon.MaximumQuantity
	couponModel.MaximumPrice = coupon.MaximumPrice
	couponModel.EndDate = coupon.EndDate
	couponModel.BeginDate = coupon.BeginDate
	couponModel.Introduction = coupon.Introduction
	couponModel.IsExchange = coupon.IsExchange
	couponModel.Prefix = coupon.Prefix
	couponModel.Condition = coupon.Condition

	err = models.UpdateCouponById(couponModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Coupon
// @router /:id [get]
func (c *CouponController) GetCoupon() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	coupon, err := models.GetCouponById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
		return
	}
	couponView := c.setCouponByCouponModel(*coupon)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, couponView)
}

// @Title Get Coupon Code Count
// @router /code/count [get]
func (c *CouponController) GetCouponCodeCount() {
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
	cnt, err := models.GetCouponCodeCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Generate Coupon Code
// @router /code/generate [post]
func (c *CouponController) GenerateCouponCode() {
	var coupon model_views.Coupon
	var quantity int

	// coupon
	if v := c.GetString("coupon"); v != "" {
		_ = json.Unmarshal([]byte(v), &coupon)
	}
	// quantity
	if v := c.GetString("quantity"); v != "" {
		quantity, _ = strconv.Atoi(v)
	}

	for i := 0; i < quantity; i++ {
		var couponCode models.CouponCode

		node, _ := helpers.NewWorker(int64(coupon.Id))
		sn := strconv.FormatInt(node.GetId(), 10)
		code := helpers.Get16Md5String(sn)

		couponCode.Code = coupon.Prefix + "_" + code
		couponCode.CouponId = &models.Coupon{Id: coupon.Id}
		_, err := models.AddCouponCode(&couponCode)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Get Coupon Count
// @router /count [get]
func (c *CouponController) GetCouponCount() {
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
	cnt, err := models.GetCouponCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title GetAllCoupon
// @Description Get all coupon by some filed
// @router / [get]
func (c *CouponController) GetAllCoupon() {
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

	query["DeleteFlag"] = "0"
	// start position of result set
	offset := (pageNumber - 1) * pageSize

	l, err := models.GetAllCoupon(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetCouponCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		coupon := v.(models.Coupon)
		couponView := c.setCouponByCouponModel(coupon)
		pageList = append(pageList, couponView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

/**
 * CouponModel 转为 CouponView
 */
func (c *CouponController) setCouponByCouponModel(coupon models.Coupon) (couponView model_views.Coupon) {
	couponView.Id = coupon.Id
	couponView.Name = coupon.Name
	couponView.Point = coupon.Point
	couponView.IsEnabled = coupon.IsEnabled
	couponView.PriceExpression = coupon.PriceExpression
	couponView.MinimumQuantity = coupon.MinimumQuantity
	couponView.MinimumPrice = coupon.MinimumPrice
	couponView.MaximumQuantity = coupon.MaximumQuantity
	couponView.MaximumPrice = coupon.MaximumPrice
	couponView.EndDate = coupon.EndDate
	couponView.BeginDate = coupon.BeginDate
	couponView.Introduction = coupon.Introduction
	couponView.IsExchange = coupon.IsExchange
	couponView.Prefix = coupon.Prefix
	couponView.Condition = coupon.Condition

	return couponView
}

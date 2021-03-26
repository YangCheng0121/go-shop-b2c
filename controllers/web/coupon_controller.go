package web

import (
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type CouponController struct {
	BaseController
}

// URLMapping ...
func (c *CouponController) URLMapping() {
	c.Mapping("ExchangeCoupon", c.ExchangeCoupon)
	c.Mapping("GetAllCoupon", c.GetAllCoupon)
}

// @Title 兑换优惠券
// @router /exchange [post]
func (c *CouponController) ExchangeCoupon() {
	var code string
	if v := c.GetString("code"); v != "" {
		code = v
	}

	couponCode, err := models.GetCouponCodeByCode(code)
	if err != nil {
		c.ServerError(err)
		return
	}

	couponCode.MemberId = &c.Member.Id

	err = models.UpdateCouponCodeById(couponCode)
	if err != nil {
		c.ServerError(err)
		return
	}
	controller := CommonController{}
	couponCodeView := controller.setCouponCodeByCouponCodeModel(*couponCode)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, couponCodeView)
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
	query["MemberId"] = strconv.Itoa(c.Member.Id)

	// start position of result set
	offset := (pageNumber - 1) * pageSize

	l, err := models.GetAllCouponCode(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetCouponCodeCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		couponCode := v.(models.CouponCode)
		controller := CommonController{}
		couponCodeView := controller.setCouponCodeByCouponCodeModel(couponCode)
		if couponCodeView.Id > 0 {
			pageList = append(pageList, couponCodeView)
		}
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

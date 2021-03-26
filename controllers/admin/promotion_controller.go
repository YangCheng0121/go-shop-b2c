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

type PromotionController struct {
	BaseController
}

// URLMapping ...
func (c *PromotionController) URLMapping() {
	c.Mapping("AddPromotion", c.AddPromotion)
	c.Mapping("DeletePromotion", c.DeletePromotion)
	c.Mapping("UpdatePromotion", c.UpdatePromotion)
	c.Mapping("GetPromotion", c.GetPromotion)
	c.Mapping("GetPromotionCount", c.GetPromotionCount)
	c.Mapping("GetAllPromotion", c.GetAllPromotion)
}

// @Title Add Promotion
// @router /add [post]
func (c *PromotionController) AddPromotion() {
	var promotion model_views.Promotion

	if v := c.GetString("promotion"); v != "" {
		_ = json.Unmarshal([]byte(v), &promotion)
	}

	var promotionModel models.Promotion
	promotionModel.Name = promotion.Name
	promotionModel.Title = promotion.Title
	promotionModel.Orders = promotion.Orders
	promotionModel.Introduction = promotion.Introduction
	promotionModel.BeginDate = promotion.BeginDate
	promotionModel.EndDate = promotion.EndDate
	promotionModel.IsCouponAllowed = promotion.IsCouponAllowed
	promotionModel.IsFreeShipping = promotion.IsFreeShipping
	promotionModel.MaximumPrice = promotion.MaximumPrice
	promotionModel.MaximumQuantity = promotion.MaximumQuantity
	promotionModel.MinimumPrice = promotion.MinimumPrice
	promotionModel.MinimumQuantity = promotion.MinimumQuantity
	promotionModel.PointExpression = promotion.PointExpression
	promotionModel.PriceExpression = promotion.PriceExpression
	promotionModel.CreateBy = c.Admin.Name

	id, err := models.AddPromotion(&promotionModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	var promotionMemberRanks []string
	for _, v := range promotion.MemberRanks {
		memberRank := strconv.Itoa(v)
		promotionMemberRanks = append(promotionMemberRanks, memberRank)
	}

	/**
	 * 添加会员等级关联
	 */
	for _, v := range promotionMemberRanks {
		if in := utils.InSlice(v, promotionMemberRanks); in == false {
			memberRank, _ := strconv.Atoi(v)
			err = models.AddPromotionMemberRank(int(id), memberRank)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	var promotionCoupons []string
	for _, v := range promotion.Coupons {
		coupon := strconv.Itoa(v)
		promotionCoupons = append(promotionCoupons, coupon)
	}

	/**
	 * 添加优惠券关联
	 */
	for _, v := range promotionCoupons {
		if in := utils.InSlice(v, promotionCoupons); in == false {
			coupon, _ := strconv.Atoi(v)
			err = models.AddPromotionCoupon(int(id), coupon)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	var promotionGifts []string
	for _, v := range promotion.Gifts {
		gift := strconv.Itoa(v.Id)
		promotionGifts = append(promotionGifts, gift)
	}

	/**
	 * 添加赠品关联
	 */
	for _, v := range promotionGifts {
		if in := utils.InSlice(v, promotionGifts); in == false {
			gift, _ := strconv.Atoi(v)
			err = models.AddPromotionGift(int(id), gift)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete Promotion
// @router /delete [delete]
func (c *PromotionController) DeletePromotion() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		err := models.DeletePromotion(id)
		if err != nil {
			c.ServerError(err)
			return
		}
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Promotion
// @router /update [put]
func (c *PromotionController) UpdatePromotion() {
	var promotion model_views.Promotion

	if v := c.GetString("promotion"); v != "" {
		_ = json.Unmarshal([]byte(v), &promotion)
	}

	promotionModel, err := models.GetPromotionById(promotion.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	promotionModel.Name = promotion.Name
	promotionModel.Title = promotion.Title
	promotionModel.Orders = promotion.Orders
	promotionModel.Introduction = promotion.Introduction
	promotionModel.BeginDate = promotion.BeginDate
	promotionModel.EndDate = promotion.EndDate
	promotionModel.IsCouponAllowed = promotion.IsCouponAllowed
	promotionModel.IsFreeShipping = promotion.IsFreeShipping
	promotionModel.MaximumPrice = promotion.MaximumPrice
	promotionModel.MaximumQuantity = promotion.MaximumQuantity
	promotionModel.MinimumPrice = promotion.MinimumPrice
	promotionModel.MinimumQuantity = promotion.MinimumQuantity
	promotionModel.PointExpression = promotion.PointExpression
	promotionModel.PriceExpression = promotion.PriceExpression
	promotionModel.LastUpdatedBy = c.Admin.Name

	err = models.UpdatePromotionById(promotionModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	var promotionMemberRanks []string
	var nextPromotionMemberRanks []string
	promotionMemberRanksModel, err := models.GetPromotionMemberRankByPromotions(promotionModel.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range promotionMemberRanksModel {
		memberRank := strconv.Itoa(v.MemberRanks)
		promotionMemberRanks = append(promotionMemberRanks, memberRank)
	}

	for _, v := range promotion.MemberRanks {
		memberRank := strconv.Itoa(v)
		nextPromotionMemberRanks = append(nextPromotionMemberRanks, memberRank)
	}

	/**
	 * 添加会员等级关联
	 */
	for _, v := range nextPromotionMemberRanks {
		if in := utils.InSlice(v, promotionMemberRanks); in == false {
			memberRank, _ := strconv.Atoi(v)
			err = models.AddPromotionMemberRank(promotionModel.Id, memberRank)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除会员等级关联
	 */
	for _, v := range promotionMemberRanks {
		if in := utils.InSlice(v, nextPromotionMemberRanks); in == false {
			memberRank, _ := strconv.Atoi(v)
			err = models.DeletePromotionMemberRank(promotionModel.Id, memberRank)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	var promotionCoupons []string
	var nextPromotionCoupons []string
	promotionCouponsModel, err := models.GetPromotionCouponByPromotions(promotionModel.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	for _, v := range promotionCouponsModel {
		coupon := strconv.Itoa(v.Coupons)
		promotionCoupons = append(promotionCoupons, coupon)
	}

	for _, v := range promotion.Coupons {
		coupon := strconv.Itoa(v)
		nextPromotionCoupons = append(nextPromotionCoupons, coupon)
	}

	/**
	 * 添加优惠券关联
	 */
	for _, v := range nextPromotionCoupons {
		if in := utils.InSlice(v, promotionCoupons); in == false {
			coupon, _ := strconv.Atoi(v)
			err = models.AddPromotionCoupon(promotionModel.Id, coupon)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除优惠券关联
	 */
	for _, v := range promotionCoupons {
		if in := utils.InSlice(v, nextPromotionCoupons); in == false {
			coupon, _ := strconv.Atoi(v)
			err = models.DeletePromotionCoupon(promotionModel.Id, coupon)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	var promotionGifts []string
	var nextPromotionGifts []string
	promotionGiftsModel, err := models.GetPromotionGiftByPromotions(promotionModel.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range promotionGiftsModel {
		gift := strconv.Itoa(v.Gifts)
		promotionGifts = append(promotionGifts, gift)
	}

	for _, v := range promotion.Gifts {
		gift := strconv.Itoa(v.Id)
		nextPromotionGifts = append(nextPromotionGifts, gift)
	}

	/**
	 * 添加赠品关联
	 */
	for _, v := range nextPromotionGifts {
		if in := utils.InSlice(v, promotionGifts); in == false {
			gift, _ := strconv.Atoi(v)
			err = models.AddPromotionGift(promotionModel.Id, gift)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	/**
	 * 删除优惠券关联
	 */
	for _, v := range promotionGifts {
		if in := utils.InSlice(v, nextPromotionGifts); in == false {
			gift, _ := strconv.Atoi(v)
			err = models.DeletePromotionGift(promotionModel.Id, gift)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Area
// @router /:id
func (c *PromotionController) GetPromotion() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	promotion, err := models.GetPromotionById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
		return
	}
	promotionView := c.setPromotionByPromotionModel(*promotion)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, promotionView)
}

// @Title Get Promotion Count
// @router /count
func (c *PromotionController) GetPromotionCount() {
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
	cnt, err := models.GetPromotionCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title GetAllPromotion
// @Description Get all promotion by some filed
// @router / [get]
func (c *PromotionController) GetAllPromotion() {
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

	l, err := models.GetAllPromotion(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetPromotionCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		promotion := v.(models.Promotion)
		promotionView := c.setPromotionByPromotionModel(promotion)
		pageList = append(pageList, promotionView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *PromotionController) setPromotionByPromotionModel(promotion models.Promotion) (promotionView model_views.Promotion) {
	promotionView.Id = promotion.Id
	promotionView.Name = promotion.Name
	promotionView.Title = promotion.Title
	promotionView.Orders = promotion.Orders
	promotionView.Introduction = promotion.Introduction
	promotionView.BeginDate = promotion.BeginDate
	promotionView.EndDate = promotion.EndDate
	promotionView.IsCouponAllowed = promotion.IsCouponAllowed
	promotionView.IsFreeShipping = promotion.IsFreeShipping
	promotionView.MaximumPrice = promotion.MaximumPrice
	promotionView.MaximumQuantity = promotion.MaximumQuantity
	promotionView.MinimumPrice = promotion.MinimumPrice
	promotionView.MinimumQuantity = promotion.MinimumQuantity
	promotionView.PointExpression = promotion.PointExpression
	promotionView.PriceExpression = promotion.PriceExpression

	/**
	 * 会员等级
	 */
	memberRanks, err := models.GetPromotionMemberRankByPromotions(promotion.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range memberRanks {
		promotionView.MemberRanks = append(promotionView.MemberRanks, v.MemberRanks)
	}

	/**
	 * 优惠券
	 */
	coupons, err := models.GetPromotionCouponByPromotions(promotion.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	for _, v := range coupons {
		promotionView.Coupons = append(promotionView.Coupons, v.Coupons)
	}

	/**
	 * 赠品
	 */
	/**
	 * 会员等级
	 */
	gifts, err := models.GetPromotionGiftByPromotions(promotion.Id)
	for _, v := range gifts {
		product, err := models.GetProductById(v.Gifts)
		if err != nil {
			c.ServerError(err)
			return
		}
		var gift model_views.Gift
		gift.Id = product.Id
		gift.Name = product.Name

		brand, err := models.GetBrandById(product.BrandId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		gift.BrandId = brand.Id
		gift.BrandName = brand.Name

		promotionView.Gifts = append(promotionView.Gifts, gift)
	}

	return promotionView
}

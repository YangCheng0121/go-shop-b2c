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

type ReviewController struct {
	BaseController
}

// URLMapping ...
func (c *ReviewController) URLMapping() {
	c.Mapping("UpdateReview", c.UpdateReview)
	c.Mapping("UpdateReviewIsShow", c.UpdateReviewIsShow)
	c.Mapping("GetReview", c.GetReview)
	c.Mapping("GetAllReview", c.GetAllReview)
}

// @Title Update Review
// @router /update [put]
func (c *ReviewController) UpdateReview() {
	var review model_views.Review

	if v := c.GetString("review"); v != "" {
		_ = json.Unmarshal([]byte(v), &review)
	}

	reviewModel, err := models.GetReviewById(review.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	reviewModel.IsShow = review.IsShow
	err = models.UpdateReviewById(reviewModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Review IsShow
// @router /toggle/is_show [post]
func (c *ReviewController) UpdateReviewIsShow() {
	var reviews []model_views.Review

	if v := c.GetString("reviews"); v != "" {
		_ = json.Unmarshal([]byte(v), &reviews)
	}

	for _, v := range reviews {
		review, err := models.GetReviewById(v.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		review.IsShow = v.IsShow

		err = models.UpdateReviewById(review)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Area
// @router /:id
func (c *ReviewController) GetReview() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	memberRank, err := models.GetReviewById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	memberRankView := c.setReviewByReviewModel(*memberRank)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberRankView)
}

// @Title GetAllReview
// @Description Get all review by some filed
// @router / [get]
func (c *ReviewController) GetAllReview() {
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
	l, err := models.GetAllReview(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetReviewCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		review := v.(models.Review)
		reviewView := c.setReviewByReviewModel(review)
		pageList = append(pageList, reviewView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *ReviewController) setReviewByReviewModel(review models.Review) (reviewView model_views.Review) {
	reviewView.Id = review.Id
	reviewView.Content = review.Content
	reviewView.IsShow = review.IsShow
	reviewView.Score = review.Score
	reviewView.Ip = review.Ip
	reviewView.CreationDate = review.CreationDate

	/**
	 * 会员
	 */
	member, err := models.GetMemberById(review.MemberId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	reviewView.MemberId = member.Id
	reviewView.Username = member.Username

	/**
	 * 商品
	 */
	product, err := models.GetProductById(review.ProductId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	reviewView.ProductId = product.Id
	reviewView.ProductName = product.Name

	return reviewView
}

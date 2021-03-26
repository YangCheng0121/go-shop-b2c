package admin

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"github.com/astaxie/beego/logs"
	"strconv"
	"strings"
)

type ProductNotify struct {
	BaseController
}

// URLMapping ...
func (c *ProductNotify) URLMapping() {
	c.Mapping("GetAllProductNotify", c.GetAllProductNotify)
}

// @Title Get All ProductNotify
// @Description get all productNotify
// @Param	query		query	string	false	"Filter. e.g. col1:v1,col2:v2 ..."
// @Param	fields		query	string	false	"Fields returned. e.g. col1,col2 ..."
// @Param	sortby		query	string	false	"Sorted-by fields. e.g. col1,col2 ..."
// @Param	order		query	string	false	"Order corresponding to each sortby field, if single value, apply to all sortby fields. e.g. desc,asc ..."
// @Param	pageSize	query	string	false	"PageSize the size of result set. Must be an integer"
// @Param	offset		query	string	false	"Start position of result set. Must be an integer"
// @router / [get]
func (c *ProductNotify) GetAllProductNotify() {
	var sortby []string
	var order []string
	var query = make(map[string]string)
	var pageNumber int64 = 1
	var pageSize int64 = 10
	var isMarketable int

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
	// isMarketable
	if v := c.GetString("is_marketable"); v != "" {
		isMarketable, _ = strconv.Atoi(v)
	}
	logs.Info("isMarketable:", isMarketable)

	// start position of result set
	offset := (pageNumber - 1) * pageSize
	/**
	 * 默认查询未删除
	 */
	query["DeleteFlag"] = "0"
	l, err := models.GetAllProductNotify(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 只返回前端需要的字段
	 */
	var pageList []interface{}
	for _, v := range l {
		productNotifyView := &model_views.ProductNotify{}
		productNotify := v.(models.ProductNotify)

		productNotifyView.Id = productNotify.Id
		productNotifyView.Email = productNotify.Email
		product, err := models.GetProductById(productNotify.ProductId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		productNotifyView.Product = &model_views.ProductNotifyProduct{}
		productNotifyView.Product.Id = product.Id
		productNotifyView.Product.Sn = product.Sn
		productNotifyView.Product.Name = product.Name
		productNotifyView.Product.IsMarketable = product.IsMarketable
		productNotifyView.Product.DeleteFlag = product.DeleteFlag
		member, err := models.GetMemberById(productNotify.MemberId.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		productNotifyView.MemberId = member.Id
		productNotifyView.MemberName = member.Username
		productNotifyView.HasSent = productNotify.HasSent
		productNotifyView.CreationDate = productNotify.CreationDate
		productNotifyView.LastUpdatedDate = productNotify.LastUpdatedDate

		pageList = append(pageList, productNotifyView)
	}

	/**
	 * 查询 ProductNotify Count
	 */
	cnt, err := models.GetProductNotifyCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}
	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

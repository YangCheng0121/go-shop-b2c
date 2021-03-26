package admin

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"encoding/json"
	"strconv"
	"strings"
)

type DeliveryCorpController struct {
	BaseController
}

// URLMapping ...
func (c *DeliveryCorpController) URLMapping() {
	c.Mapping("AddDeliveryCorp", c.AddDeliveryCorp)
	c.Mapping("DeleteDeliveryCorp", c.DeleteDeliveryCorp)
	c.Mapping("UpdateDeliveryCorp", c.UpdateDeliveryCorp)
	c.Mapping("GeDeliveryCorpCount", c.GeDeliveryCorpCount)
	c.Mapping("GetDeliveryCorp", c.GetDeliveryCorp)
	c.Mapping("GetAllDeliveryCorp", c.GetAllDeliveryCorp)
}

// @Title Add DeliveryCorp
// @router /add [post]
func (c *DeliveryCorpController) AddDeliveryCorp() {
	var deliveryCorp model_views.DeliveryCorp

	if v := c.GetString("delivery_corp"); v != "" {
		_ = json.Unmarshal([]byte(v), &deliveryCorp)
	}

	var deliveryCorpModel models.DeliveryCorp
	deliveryCorpModel.Id = deliveryCorp.Id
	deliveryCorpModel.Name = deliveryCorp.Name
	deliveryCorpModel.Orders = deliveryCorp.Orders
	deliveryCorpModel.Code = deliveryCorp.Code
	deliveryCorpModel.Url = deliveryCorp.Url

	_, err := models.AddDeliveryCorp(&deliveryCorpModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete DeliveryCorp
// @router /delete [delete]
func (c *DeliveryCorpController) DeleteDeliveryCorp() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		deliveryCorp, err := models.GetDeliveryCorpById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		deliveryCorp.LastUpdatedBy = c.Admin.Name
		deliveryCorp.DeleteFlag = 1

		err = models.UpdateDeliveryCorpById(deliveryCorp)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update DeliveryCorp
// @router /update [put]
func (c *DeliveryCorpController) UpdateDeliveryCorp() {
	var deliveryCorp model_views.DeliveryCorp

	if v := c.GetString("delivery_corp"); v != "" {
		_ = json.Unmarshal([]byte(v), &deliveryCorp)
	}

	deliveryCorpModel, err := models.GetDeliveryCorpById(deliveryCorp.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	deliveryCorpModel.Id = deliveryCorp.Id
	deliveryCorpModel.Name = deliveryCorp.Name
	deliveryCorpModel.Orders = deliveryCorp.Orders
	deliveryCorpModel.Code = deliveryCorp.Code
	deliveryCorpModel.Url = deliveryCorp.Url

	err = models.UpdateDeliveryCorpById(deliveryCorpModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// Get DeliveryCorp Count
// @router /count [get]
func (c *DeliveryCorpController) GeDeliveryCorpCount() {
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
	cnt, err := models.GetDeliveryCorpCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get DeliveryCorp
// @router /:id [get]
func (c *DeliveryCorpController) GetDeliveryCorp() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	deliveryCorp, err := models.GetDeliveryCorpById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	deliveryCorpView := c.setDeliveryCorpByDeliveryCorpModel(*deliveryCorp)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, deliveryCorpView)
}

// @Title Get All DeliveryCorp
// @router / [get]
func (c *DeliveryCorpController) GetAllDeliveryCorp() {
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
	cnt, err := models.GetDeliveryCorpCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllDeliveryCorp(query, nil, sortby, order, offset, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		deliveryCorp := v.(models.DeliveryCorp)
		deliveryCorpView := c.setDeliveryCorpByDeliveryCorpModel(deliveryCorp)
		pageList = append(pageList, deliveryCorpView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

/**
 * DeliveryCorpModel 转为 DeliveryCorpView
 */
func (c *DeliveryCorpController) setDeliveryCorpByDeliveryCorpModel(deliveryCorp models.DeliveryCorp) (deliveryCorpView model_views.DeliveryCorp) {
	deliveryCorpView.Id = deliveryCorp.Id
	deliveryCorpView.Name = deliveryCorp.Name
	deliveryCorpView.Orders = deliveryCorp.Orders
	deliveryCorpView.Code = deliveryCorp.Code
	deliveryCorpView.Url = deliveryCorp.Url

	return deliveryCorpView
}

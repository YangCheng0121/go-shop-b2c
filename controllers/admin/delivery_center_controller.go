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

type DeliveryCenterController struct {
	BaseController
}

// URLMapping ...
func (c *DeliveryCenterController) URLMapping() {
	c.Mapping("AddDeliveryCenter", c.AddDeliveryCenter)
	c.Mapping("DeleteDeliveryCenter", c.DeleteDeliveryCenter)
	c.Mapping("UpdateDeliveryCenter", c.UpdateDeliveryCenter)
	c.Mapping("GeDeliveryCenterCount", c.GeDeliveryCenterCount)
	c.Mapping("GetDeliveryCenter", c.GetDeliveryCenter)
	c.Mapping("GetAllDeliveryCenter", c.GetAllDeliveryCenter)
}

// @Title Add DeliveryCenter
// @router /add [post]
func (c *DeliveryCenterController) AddDeliveryCenter() {
	var deliveryCenter model_views.DeliveryCenter

	if v := c.GetString("delivery_center"); v != "" {
		_ = json.Unmarshal([]byte(v), &deliveryCenter)
	}

	var deliveryCenterModel models.DeliveryCenter
	deliveryCenterModel.Id = deliveryCenter.Id
	deliveryCenterModel.Name = deliveryCenter.Name
	deliveryCenterModel.ZipCode = deliveryCenter.ZipCode
	deliveryCenterModel.Phone = deliveryCenter.Phone
	deliveryCenterModel.Memo = deliveryCenter.Memo
	deliveryCenterModel.Address = deliveryCenter.Address
	deliveryCenterModel.IsDefault = deliveryCenter.IsDefault
	deliveryCenterModel.AreaId = deliveryCenter.AreaId
	deliveryCenterModel.AreaName = deliveryCenter.AreaName
	deliveryCenterModel.Contact = deliveryCenter.Contact
	deliveryCenterModel.Mobile = deliveryCenter.Mobile

	_, err := models.AddDeliveryCenter(&deliveryCenterModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Delete DeliveryCenter
// @router /delete [delete]
func (c *DeliveryCenterController) DeleteDeliveryCenter() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, idStr := range ids {
		id, _ := strconv.Atoi(idStr)

		deliveryCenter, err := models.GetDeliveryCenterById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		deliveryCenter.LastUpdatedBy = c.Admin.Name
		deliveryCenter.DeleteFlag = 1

		err = models.UpdateDeliveryCenterById(deliveryCenter)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update DeliveryCenter
// @router /update [put]
func (c *DeliveryCenterController) UpdateDeliveryCenter() {
	var deliveryCenter model_views.DeliveryCenter

	if v := c.GetString("delivery_center"); v != "" {
		_ = json.Unmarshal([]byte(v), &deliveryCenter)
	}

	deliveryCenterModel, err := models.GetDeliveryCenterById(deliveryCenter.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	deliveryCenterModel.Name = deliveryCenter.Name
	deliveryCenterModel.ZipCode = deliveryCenter.ZipCode
	deliveryCenterModel.Phone = deliveryCenter.Phone
	deliveryCenterModel.Memo = deliveryCenter.Memo
	deliveryCenterModel.Address = deliveryCenter.Address
	deliveryCenterModel.IsDefault = deliveryCenter.IsDefault
	deliveryCenterModel.AreaId = deliveryCenter.AreaId
	deliveryCenterModel.AreaName = deliveryCenter.AreaName
	deliveryCenterModel.Contact = deliveryCenter.Contact
	deliveryCenterModel.Mobile = deliveryCenter.Mobile

	err = models.UpdateDeliveryCenterById(deliveryCenterModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// Get DeliveryCenter Count
// @router /count [get]
func (c *DeliveryCenterController) GeDeliveryCenterCount() {
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
	cnt, err := models.GetDeliveryCenterCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cnt)
}

// @Title Get DeliveryCenter
// @router /:id [get]
func (c *DeliveryCenterController) GetDeliveryCenter() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	deliveryCenter, err := models.GetDeliveryCenterById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	deliveryCenterView := c.setDeliveryCenterByDeliveryCenterModel(*deliveryCenter)
	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, deliveryCenterView)
}

// @Title Get All DeliveryCenter
// @router / [get]
func (c *DeliveryCenterController) GetAllDeliveryCenter() {
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
	cnt, err := models.GetDeliveryCenterCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllDeliveryCenter(query, nil, sortby, order, offset, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		deliveryCenter := v.(models.DeliveryCenter)
		deliveryCenterView := c.setDeliveryCenterByDeliveryCenterModel(deliveryCenter)
		pageList = append(pageList, deliveryCenterView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *DeliveryCenterController) setDeliveryCenterByDeliveryCenterModel(deliveryCenter models.DeliveryCenter) (deliveryCenterView model_views.DeliveryCenter) {
	deliveryCenterView.Id = deliveryCenter.Id
	deliveryCenterView.Name = deliveryCenter.Name
	deliveryCenterView.ZipCode = deliveryCenter.ZipCode
	deliveryCenterView.Phone = deliveryCenter.Phone
	deliveryCenterView.Memo = deliveryCenter.Memo
	deliveryCenterView.Address = deliveryCenter.Address
	deliveryCenterView.IsDefault = deliveryCenter.IsDefault
	deliveryCenterView.AreaId = deliveryCenter.AreaId
	deliveryCenterView.AreaName = deliveryCenter.AreaName
	deliveryCenterView.Contact = deliveryCenter.Contact
	deliveryCenterView.Mobile = deliveryCenter.Mobile

	return deliveryCenterView
}

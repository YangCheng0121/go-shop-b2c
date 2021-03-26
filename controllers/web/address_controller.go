package web

import (
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"encoding/json"
	"strconv"
	"strings"
)

type AddressController struct {
	BaseController
}

// URLMapping ...
func (c *AddressController) URLMapping() {
	c.Mapping("AddAddress", c.AddAddress)
	c.Mapping("DeleteAddress", c.DeleteAddress)
	c.Mapping("UpdateAddress", c.UpdateAddress)
	c.Mapping("GetAllAddress", c.GetAllAddress)
}

// @Title 新增地址
// @router /add [post]
func (c *AddressController) AddAddress() {
	var address model_views.Receiver

	if v := c.GetString("address"); v != "" {
		_ = json.Unmarshal([]byte(v), &address)
	}

	var receiver models.Receiver
	receiver.Id = address.Id
	receiver.Consignee = address.Consignee
	receiver.AreaName = address.AreaName
	receiver.AreaId = address.AreaId
	receiver.Address = address.Address
	receiver.IsDefault = address.IsDefault
	receiver.Phone = address.Phone
	receiver.ZipCode = address.ZipCode
	receiver.MemberId = int64(c.Member.Id)
	receiver.LastUpdatedBy = c.Member.Username

	_, err := models.AddReceiver(&receiver)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title 删除地址
// @router /delete [delete]
func (c *AddressController) DeleteAddress() {
	var ids []string

	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, v := range ids {
		id, _ := strconv.Atoi(v)
		receiver, err := models.GetReceiverById(id)
		if err != nil {
			c.ServerError(err)
			return
		}

		receiver.LastUpdatedBy = c.Member.Username
		receiver.DeleteFlag = 1

		err = models.UpdateReceiverById(receiver)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title 更新地址
// @router /update [post]
func (c *AddressController) UpdateAddress() {
	var address model_views.Receiver

	if v := c.GetString("address"); v != "" {
		_ = json.Unmarshal([]byte(v), &address)
	}

	receiver, err := models.GetReceiverByIdAndMemberId(address.Id, c.Member.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	if address.IsDefault == 1 {
		defaultReceiver, err := models.GetDefaultReceiverByMemberId(c.Member.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		if defaultReceiver.Id != receiver.Id {
			defaultReceiver.IsDefault = 0
			err = models.UpdateReceiverById(defaultReceiver)
			if err != nil {
				c.ServerError(err)
				return
			}
		}
	}

	receiver.Consignee = address.Consignee
	receiver.AreaName = address.AreaName
	receiver.AreaId = address.AreaId
	receiver.Address = address.Address
	receiver.IsDefault = address.IsDefault
	receiver.Phone = address.Phone
	receiver.ZipCode = address.ZipCode
	receiver.MemberId = address.MemberId
	receiver.LastUpdatedBy = c.Member.Username

	err = models.UpdateReceiverById(receiver)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title 获取地址
// @router /:id
func (c *AddressController) GetAddress() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	receiver, err := models.GetReceiverById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	controller := CommonController{}
	receiverView := controller.setReceiverByReceiverModel(*receiver)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, receiverView)
}

// @Title 获取地址列表
// @router / [get]
func (c *AddressController) GetAllAddress() {
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

	l, err := models.GetAllReceiver(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetReceiverCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		receiver := v.(models.Receiver)
		controller := CommonController{}
		receiverView := controller.setReceiverByReceiverModel(receiver)

		pageList = append(pageList, receiverView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

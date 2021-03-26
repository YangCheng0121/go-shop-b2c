package admin

import (
	"bee-shop-b2c/common/http"
	messageConfigHelper "bee-shop-b2c/common/message_config"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"encoding/json"
	"strconv"
	"strings"
)

type MessageConfigController struct {
	BaseController
}

// URLMapping ...
func (c *MessageConfigController) URLMapping() {
	c.Mapping("UpdateMessageConfig", c.UpdateMessageConfig)
	c.Mapping("GetMessageConfig", c.GetMessageConfig)
	c.Mapping("GetAllMessageConfig", c.GetAllMessageConfig)
}

// @Title Update MessageConfig
// @router /update [put]
func (c *MessageConfigController) UpdateMessageConfig() {
	var messageConfig model_views.MessageConfig

	if v := c.GetString("message_config"); v != "" {
		_ = json.Unmarshal([]byte(v), &messageConfig)
	}

	messageConfigModel, err := models.GetMessageConfigById(messageConfig.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	messageConfigModel.IsSmsEnabled = messageConfig.IsSmsEnabled
	messageConfigModel.IsMailEnabled = messageConfig.IsMailEnabled
	messageConfigModel.LastUpdatedBy = c.Admin.Username

	err = models.UpdateMessageConfigById(messageConfigModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get MessageConfig
// @router /:id [get]
func (c *MessageConfigController) GetMessageConfig() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	memberRank, err := models.GetMessageConfigById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	memberRankView := c.setMessageConfigByMessageConfigModel(*memberRank)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberRankView)
}

// @Title GetAllMessageConfig
// @Description Get all messageConfig by some filed
// @router / [get]
func (c *MessageConfigController) GetAllMessageConfig() {
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
	l, err := models.GetAllMessageConfig(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetMessageConfigCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		messageConfig := v.(models.MessageConfig)
		messageConfigView := c.setMessageConfigByMessageConfigModel(messageConfig)
		pageList = append(pageList, messageConfigView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *MessageConfigController) setMessageConfigByMessageConfigModel(messageConfig models.MessageConfig) (messageConfigView model_views.MessageConfig) {
	messageConfigView.Id = messageConfig.Id
	messageConfigView.Type = messageConfig.Type
	messageConfigView.TypeName = messageConfigHelper.GetMessageTypeName(messageConfig.Type)
	messageConfigView.IsMailEnabled = messageConfig.IsMailEnabled
	messageConfigView.IsSmsEnabled = messageConfig.IsSmsEnabled

	return messageConfigView
}

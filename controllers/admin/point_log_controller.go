package admin

import (
	"encoding/json"
	"go-shop-b2c/common/http"
	pointLogHelper "go-shop-b2c/common/point_log"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type PointLogController struct {
	BaseController
}

// URLMapping ...
func (c *PointLogController) URLMapping() {
	c.Mapping("AddPointLog", c.AddPointLog)
	c.Mapping("GetPointLog", c.GetPointLog)
	c.Mapping("GetAllPointLog", c.GetAllPointLog)
}

// @Title Add PointLog
// @router /add [post]
func (c *PointLogController) AddPointLog() {
	var pointLog model_views.PointLog

	if v := c.GetString("point_log"); v != "" {
		_ = json.Unmarshal([]byte(v), &pointLog)
	}

	var pointLogModel models.PointLog
	pointLogModel.Balance = pointLog.Balance
	pointLogModel.Credit = pointLog.Credit
	pointLogModel.Debit = pointLog.Debit
	pointLogModel.Memo = pointLog.Memo
	pointLogModel.Type = pointLog.Type

	member, err := models.GetMemberByUsername(pointLog.Username)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "当前用户不存在")
		return
	}

	pointLogModel.MemberId = &models.Member{Id: member.Id}

	_, err = models.AddPointLog(&pointLogModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Get Area
// @router /:id
func (c *PointLogController) GetPointLog() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	memberRank, err := models.GetPointLogById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
		return
	}
	memberRankView := c.setPointLogByPointLogModel(*memberRank)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberRankView)
}

// @Title GetAllPointLog
// @Description Get all pointLog by some filed
// @router / [get]
func (c *PointLogController) GetAllPointLog() {
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

	l, err := models.GetAllPointLog(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetPointLogCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		pointLog := v.(models.PointLog)
		pointLogView := c.setPointLogByPointLogModel(pointLog)
		pageList = append(pageList, pointLogView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *PointLogController) setPointLogByPointLogModel(pointLog models.PointLog) (pointLogView model_views.PointLog) {
	pointLogView.Id = pointLog.Id
	pointLogView.Balance = pointLog.Balance
	pointLogView.Credit = pointLog.Credit
	pointLogView.Debit = pointLog.Debit
	pointLogView.Memo = pointLog.Memo
	pointLogView.Type = pointLog.Type
	pointLogView.TypeName = pointLogHelper.GetPointLogName(pointLog.Type)
	pointLogView.CreationDate = pointLog.CreationDate

	member, err := models.GetMemberById(pointLog.MemberId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	pointLogView.MemberId = member.Id
	pointLogView.Username = member.Username

	return pointLogView
}

package admin

import (
	depositHelper "bee-shop-b2c/common/deposit_log"
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"encoding/json"
	"strconv"
	"strings"
)

type DepositLogController struct {
	BaseController
}

// URLMapping ...
func (c *DepositLogController) URLMapping() {
	c.Mapping("AddDepositLog", c.AddDepositLog)
	c.Mapping("GetDepositLog", c.GetDepositLog)
	c.Mapping("GetAllDepositLog", c.GetAllDepositLog)
}

// @Title Add DepositLog
// @router /add [post]
func (c *DepositLogController) AddDepositLog() {
	var depositLog model_views.DepositLog

	if v := c.GetString("deposit_log"); v != "" {
		_ = json.Unmarshal([]byte(v), &depositLog)
	}

	var depositLogModel models.DepositLog
	depositLogModel.Id = depositLog.Id
	depositLogModel.Type = depositLog.Type
	depositLogModel.MemberId = &models.Member{Id: depositLog.MemberId}
	depositLogModel.Memo = depositLog.Memo
	depositLogModel.Credit = depositLog.Credit
	depositLogModel.Balance = depositLog.Balance
	depositLogModel.CreationDate = depositLog.CreationDate
	depositLogModel.Detinyint = depositLog.Detinyint
	depositLogModel.Operator = c.Admin.Username
	depositLogModel.CreateBy = c.Admin.Username

	member, err := models.GetMemberByUsername(depositLog.Username)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrError, http.Fail, "当前用户不存在")
		return
	}
	// 收入金额
	if depositLog.Credit > 0 {
		member.Balance = member.Balance + depositLog.Credit
	}
	// 支付金额
	if depositLog.Detinyint > 0 {
		member.Balance = member.Balance + depositLog.Detinyint
	}

	depositLogModel.MemberId = &models.Member{Id: member.Id}
	_, err = models.AddDepositLog(&depositLogModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	/**
	 * 更新会员余额
	 */
	err = models.UpdateMemberById(member)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("created"), http.ErrOK, http.Success, nil)
}

// @Title Get Deposit Log
// @router /:id [get]
func (c *DepositLogController) GetDepositLog() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	memberRank, err := models.GetDepositLogById(id)
	if err != nil {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
		return
	}
	memberRankView := c.setDepositLogByDepositLogModel(*memberRank)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberRankView)
}

// @Title GetAllDepositLog
// @Description Get all depositLog by some filed
// @router / [get]
func (c *DepositLogController) GetAllDepositLog() {
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
	l, err := models.GetAllDepositLog(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetDepositLogCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		depositLog := v.(models.DepositLog)
		depositLogView := c.setDepositLogByDepositLogModel(depositLog)
		pageList = append(pageList, depositLogView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *DepositLogController) setDepositLogByDepositLogModel(depositLog models.DepositLog) (depositLogView model_views.DepositLog) {
	depositLogView.Id = depositLog.Id
	depositLogView.Type = depositLog.Type
	depositLogView.TypeName = depositHelper.GetDepositLogName(depositLog.Type)
	depositLogView.Memo = depositLog.Memo
	depositLogView.Credit = depositLog.Credit
	depositLogView.Balance = depositLog.Balance
	depositLogView.Operator = c.Admin.Username
	depositLogView.CreationDate = depositLog.CreationDate
	depositLogView.Detinyint = depositLog.Detinyint

	member, err := models.GetMemberById(depositLog.MemberId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	depositLogView.MemberId = member.Id
	depositLogView.Username = member.Username

	return depositLogView
}

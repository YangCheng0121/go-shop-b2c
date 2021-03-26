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

type ConsultationController struct {
	BaseController
}

// URLMapping ...
func (c *ConsultationController) URLMapping() {
	c.Mapping("UpdateConsultation", c.UpdateConsultation)
	c.Mapping("UpdateConsultationIsShow", c.UpdateConsultationIsShow)
	c.Mapping("GetConsultation", c.GetConsultation)
	c.Mapping("GetAllConsultation", c.GetAllConsultation)
}

// @Title Update Consultation
// @router /update [put]
func (c *ConsultationController) UpdateConsultation() {
	var consultation model_views.Consultation

	if v := c.GetString("consultation"); v != "" {
		_ = json.Unmarshal([]byte(v), &consultation)
	}

	consultationModel, err := models.GetConsultationById(consultation.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	var forConsultation models.Consultation
	consultationModel.ForConsultation = nil
	if consultation.Reply != "" {
		forConsultation.Content = consultation.Reply
		forConsultation.ForConsultation = &consultationModel.Id
		forConsultation.ProductId = consultationModel.ProductId
		forConsultation.MemberId = nil
		forConsultation.Ip = c.Ctx.Input.IP()
		id, err := models.AddConsultation(&forConsultation)
		if err != nil {
			c.ServerError(err)
			return
		}

		forConsultationId := int(id)
		consultationModel.ForConsultation = &forConsultationId
	}

	consultationModel.IsShow = consultation.IsShow
	consultationModel.LastUpdatedBy = c.Admin.Username
	err = models.UpdateConsultationById(consultationModel)
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Update Consultation IsShow
// @router /toggle/is_show [post]
func (c *ConsultationController) UpdateConsultationIsShow() {
	var consultations []model_views.Consultation

	if v := c.GetString("consultations"); v != "" {
		_ = json.Unmarshal([]byte(v), &consultations)
	}

	for _, v := range consultations {
		consultation, err := models.GetConsultationById(v.Id)
		if err != nil {
			c.ServerError(err)
			return
		}
		consultation.IsShow = v.IsShow
		consultation.LastUpdatedBy = c.Admin.Username
		err = models.UpdateConsultationById(consultation)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title Get Consultation
// @router /:id [get]
func (c *ConsultationController) GetConsultation() {
	idStr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idStr)

	memberRank, err := models.GetConsultationById(id)
	if err != nil {
		c.ServerError(err)
		return
	}
	memberRankView := c.setConsultationByConsultationModel(*memberRank)

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberRankView)
}

// @Title GetAllConsultation
// @Description Get all consultation by some filed
// @router / [get]
func (c *ConsultationController) GetAllConsultation() {
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
	query["MemberId__gt"] = "0"
	// start position of result set
	offset := (pageNumber - 1) * pageSize
	l, err := models.GetAllConsultation(query, nil, sortby, order, offset, pageSize)
	if err != nil {
		c.ServerError(err)
		return
	}

	cnt, err := models.GetConsultationCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	var pageList []interface{}
	for _, v := range l {
		consultation := v.(models.Consultation)
		consultationView := c.setConsultationByConsultationModel(consultation)
		pageList = append(pageList, consultationView)
	}

	pages, err := helpers.NewPagination(pageList, int(cnt), int(pageSize), int(pageNumber))
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, pages)
}

func (c *ConsultationController) setConsultationByConsultationModel(consultation models.Consultation) (consultationView model_views.Consultation) {
	consultationView.Id = consultation.Id
	consultationView.Content = consultation.Content
	consultationView.IsShow = consultation.IsShow
	consultationView.Ip = consultation.Ip
	consultationView.CreationDate = consultation.CreationDate

	var query = make(map[string]string)
	query["DeleteFlag"] = "0"
	query["ForConsultation"] = strconv.Itoa(consultation.Id)
	cnt, err := models.GetConsultationCount(query)
	if err != nil {
		c.ServerError(err)
		return
	}

	l, err := models.GetAllConsultation(query, nil, nil, nil, 0, cnt)
	if err != nil {
		c.ServerError(err)
		return
	}

	if len(l) > 0 {
		for _, v := range l {
			v := v.(models.Consultation)
			forConsultationView := &model_views.Consultation{}
			forConsultationView.Id = v.Id
			forConsultationView.Content = v.Content
			forConsultationView.IsShow = v.IsShow
			forConsultationView.Ip = v.Ip
			forConsultationView.CreationDate = v.CreationDate

			consultationView.ForConsultation = append(consultationView.ForConsultation, *forConsultationView)
		}
	}

	/**
	 * 会员
	 */
	if consultation.MemberId != nil {
		member, err := models.GetMemberById(*consultation.MemberId)
		if err != nil {
			c.ServerError(err)
			return
		}
		consultationView.MemberId = &member.Id
		consultationView.Username = member.Username
	}

	/**
	 * 商品
	 */
	product, err := models.GetProductById(consultation.ProductId.Id)
	if err != nil {
		c.ServerError(err)
		return
	}
	consultationView.ProductId = product.Id
	consultationView.ProductName = product.Name

	return consultationView
}

package model_views

import "time"

type Ad struct {
	Id           int        `json:"id" description:"主键_id"`
	Title        string     `json:"title" description:"标题"`
	Type         int        `json:"type" description:"类型"`
	Content      string     `json:"content" description:"内容"`
	AdPositionId int64      `json:"ad_position_id" description:"广告位"`
	AdPosition   string     `json:"ad_position" description:"广告位名称"`
	Path         string     `json:"path" description:"路径"`
	Url          string     `json:"url" description:"链接地址"`
	BeginDate    *time.Time `json:"begin_date" description:"起始日期"`
	EndDate      *time.Time `json:"end_date" description:"结束日期"`
	Orders       int        `json:"orders" description:"排序"`
}

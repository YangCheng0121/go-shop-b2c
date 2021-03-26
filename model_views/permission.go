package model_views

type Permission struct {
	Id          int    `json:"id" description:"主键_id"`
	Name        string `json:"name" description:"名称"`
	Value       string `json:"value" description:"值"`
	Module      string `json:"module" description:"所属模块"`
	Description string `json:"description" description:"简介"`
}

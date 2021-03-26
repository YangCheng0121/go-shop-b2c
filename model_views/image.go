package model_views

type Image struct {
	Id       int         `json:"id"`
	Uid      interface{} `json:"uid"`
	Name     string      `json:"name"`
	Status   string      `json:"status"`
	ThumbUrl string      `json:"thumbUrl"`
	Source   string      `json:"source"`
	Large    string      `json:"large"`
	Medium   string      `json:"medium"`
	Url      string      `json:"url"`
}

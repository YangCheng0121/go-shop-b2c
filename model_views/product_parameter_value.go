package model_views

type ProductParameterValue struct {
	Id    int    `json:"id"`
	Value string `json:"value" description:"参数_value"`
}

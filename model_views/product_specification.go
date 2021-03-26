package model_views

type ProductSpecification struct {
	Id      int                          `json:"id" description:"规格_id"`
	Name    string                       `json:"name" description:"规格"`
	Options []ProductSpecificationValues `json:"options" description:"规格项"`
}

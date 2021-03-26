package model_views

type ProductSpecificationValues struct {
	SpecificationId   int    `json:"specification_id" description:"规格_id"`
	SpecificationName string `json:"specification_name" description:"规格_name"`
	ValueId           int    `json:"value_id" description:"规格值_id"`
	Value             string `json:"value" description:"规格值"`
}

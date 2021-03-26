package model_views

type ProductSku struct {
	Id                     int                          `json:"sku_id" description:"主键_id"`
	Stock                  int                          `json:"stock" description:"库存"`
	Cost                   float64                      `json:"cost" description:"成本价"`
	MarketPrice            float64                      `json:"market_price" description:"市场价"`
	Price                  float64                      `json:"price" description:"售价"`
	ExchangePoint          int64                        `json:"exchange_point" description:"兑换积分"`
	RewardPoint            int64                        `json:"reward_point" description:"赠送积分"`
	Sn                     string                       `json:"sn" description:"编号"`
	SpecificationValues    string                       `json:"specification_values" description:"规格值"`
	SpecificationValuesArr []ProductSpecificationValues `json:"specification_values_arr" description:"规格值数组"`
	ProductId              int                          `json:"product_id" description:"商品"`
	IsDefault              int8                         `json:"is_default" description:"是否默认"`
	IsEnable               int8                         `json:"is_enable" description:"是否启用"`
}

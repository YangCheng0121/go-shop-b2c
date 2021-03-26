package model_views

import (
	"time"
)

type Product struct {
	Id                  int                     `json:"id" description:"主键_id"`
	Sn                  string                  `json:"sn" description:"编号"`
	Name                string                  `json:"name" description:"名称"`
	Caption             string                  `json:"caption" description:"副标题"`
	Type                string                  `json:"type" description:"类型"`
	Image               *Image                  `json:"image" description:"展示图片"`
	ProductImages       []Image                 `json:"product_images" description:"商品图片"`
	ProductCategoryId   int                     `json:"product_category_id" description:"商品分类ID"`
	ProductCategoryName string                  `json:"product_category_name" description:"商品分类名称"`
	IsMarketable        int8                    `json:"is_marketable" description:"是否上架"`
	IsList              int8                    `json:"is_list" description:"是否列出"`
	IsTop               int8                    `json:"is_top" description:"是否置顶"`
	IsDelivery          int8                    `json:"is_delivery" description:"是否需要物流"`
	Introduction        string                  `json:"introduction" description:"介绍"`
	Unit                string                  `json:"unit" description:"单位"`
	Weight              int                     `json:"weight" description:"重量"`
	BrandId             int                     `json:"brand_id" description:"品牌"`
	BrandName           string                  `json:"brand_name" description:"品牌名称"`
	Tags                []int                   `json:"tags" description:"标签"`
	Promotions          []Promotion             `json:"promotions" description:"促销"`
	AttributeValue0     string                  `json:"attribute_value_0" description:"商品属性值0"`
	AttributeValue1     string                  `json:"attribute_value_1" description:"商品属性值1"`
	AttributeValue2     string                  `json:"attribute_value_2" description:"商品属性值2"`
	AttributeValue3     string                  `json:"attribute_value_3" description:"商品属性值3"`
	AttributeValue4     string                  `json:"attribute_value_4" description:"商品属性值4"`
	AttributeValue5     string                  `json:"attribute_value_5" description:"商品属性值5"`
	AttributeValue6     string                  `json:"attribute_value_6" description:"商品属性值6"`
	AttributeValue7     string                  `json:"attribute_value_7" description:"商品属性值7"`
	AttributeValue8     string                  `json:"attribute_value_8" description:"商品属性值8"`
	AttributeValue9     string                  `json:"attribute_value_9" description:"商品属性值9"`
	AttributeValue10    string                  `json:"attribute_value_10" description:"商品属性值10"`
	AttributeValue11    string                  `json:"attribute_value_11" description:"商品属性值11"`
	AttributeValue12    string                  `json:"attribute_value_12" description:"商品属性值12"`
	AttributeValue13    string                  `json:"attribute_value_13" description:"商品属性值13"`
	AttributeValue14    string                  `json:"attribute_value_14" description:"商品属性值14"`
	AttributeValue15    string                  `json:"attribute_value_15" description:"商品属性值15"`
	AttributeValue16    string                  `json:"attribute_value_16" description:"商品属性值16"`
	AttributeValue17    string                  `json:"attribute_value_17" description:"商品属性值17"`
	AttributeValue18    string                  `json:"attribute_value_18" description:"商品属性值18"`
	AttributeValue19    string                  `json:"attribute_value_19" description:"商品属性19"`
	Memo                string                  `json:"memo" description:"备注"`
	Keyword             string                  `json:"keyword" description:"搜索关键词"`
	SeoTitle            string                  `json:"seo_title" description:"页面标题"`
	SeoKeywords         string                  `json:"seo_keywords" description:"页面关键词"`
	SeoDescription      string                  `json:"seo_description" description:"页面描述"`
	Skus                []ProductSku            `json:"skus" description:"库存单元"`
	Parameters          []ProductParameterValue `json:"parameters" description:"商品参数"`
	CreationDate        time.Time               `json:"creation_date" description:"创建日期"`
}

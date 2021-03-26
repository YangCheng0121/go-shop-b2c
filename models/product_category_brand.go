package models

type ProductCategoryBrand struct {
	ProductCategories *ProductCategory `orm:"column(product_categories);rel(fk)"`
	Brands            *Brand           `orm:"column(brands);rel(fk)"`
}

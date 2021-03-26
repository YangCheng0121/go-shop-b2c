package models

type ArticleTag struct {
	Articles *Article `orm:"column(articles);rel(fk)"`
	Tags     *Tag     `orm:"column(tags);rel(fk)"`
}

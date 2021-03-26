package models

type MemberFavoriteProduct struct {
	FavoriteMembers  *Member  `orm:"column(favorite_members);rel(fk)"`
	FavoriteProducts *Product `orm:"column(favorite_products);rel(fk)"`
}

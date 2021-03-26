package web

import (
	"encoding/json"
	uuid "github.com/satori/go.uuid"
	"go-shop-b2c/common"
	"go-shop-b2c/common/http"
	"go-shop-b2c/helpers"
	"go-shop-b2c/model_views"
	"go-shop-b2c/models"
	"strconv"
	"strings"
)

type ShopCartController struct {
	JsonController
}

// URLMapping ...
func (c *ShopCartController) URLMapping() {
	c.Mapping("AddShopCartItem", c.AddShopCartItem)
	c.Mapping("DeleteShopCartItem", c.DeleteShopCartItem)
	c.Mapping("UpdateShopCartItem", c.UpdateShopCartItem)
	c.Mapping("GetShopCartItems", c.GetShopCartItems)
	c.Mapping("GetShopCartCount", c.GetShopCartCount)
}

// @Title 添加购物车项
// @router /add [post]
func (c *ShopCartController) AddShopCartItem() {
	var cartKey string
	var skuId int
	var quantity int
	var cartModel models.Cart

	// cartKey
	cartKey = c.GetString("cartKey")
	// sku
	if v := c.GetString("skuId"); v != "" {
		skuId, _ = strconv.Atoi(v)
	}
	// quantity
	if v := c.GetString("quantity"); v != "" {
		quantity, _ = strconv.Atoi(v)
	}

	var cookieMember CookieMember
	if cookie, ok := c.GetSecureCookie(common.AppKey(), "web_login"); ok {
		_ = helpers.Decode(cookie, &cookieMember)
	} else {
		c.JsonResult(http.GetHttpStatusByAlias("ok"), http.UNAUTHORIZED, http.Fail, nil)
		return
	}

	member, _ := models.GetMemberById(cookieMember.MemberId)

	if cartKey == "" {
		cartModel.CartKey = c.generateCartKey()
		if member != nil {
			cartModel.MemberId = &models.Member{Id: member.Id}
			cartModel.CreateBy = member.Username
		}
		id, err := models.AddCart(&cartModel)
		if err != nil {
			c.ServerError(err)
			return
		}
		cartModel.Id = int(id)
	} else {
		cart, err := models.GetCartByCartKey(cartKey)
		if err != nil {
			c.ServerError(err)
			return
		}
		cartModel = *cart
	}

	cartItem, _ := models.GetCartItemBySkuIdAndCartId(skuId, cartModel.Id)

	if cartItem == nil {
		var cartItem models.CartItem
		cartItem.SkuId = &models.Sku{Id: skuId}
		cartItem.CartId = &cartModel
		cartItem.Quantity = quantity
		if member != nil {
			cartItem.CreateBy = member.Username
		}

		_, err := models.AddCartItem(&cartItem)
		if err != nil {
			c.ServerError(err)
			return
		}
	} else {
		cartItem.Quantity = cartItem.Quantity + quantity
		err := models.UpdateCartItemById(cartItem)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, cartModel.CartKey)
}

// @Title 删除购物车项
// @router /delete [delete]
func (c *ShopCartController) DeleteShopCartItem() {
	var ids []string
	// ids
	if v := c.GetString("ids"); v != "" {
		ids = strings.Split(v, ",")
	}

	for _, v := range ids {
		id, _ := strconv.Atoi(v)

		cartItem, err := models.GetCartItemById(id)
		if err != nil {
			c.ServerError(err)
			return
		}
		cartItem.DeleteFlag = 1

		err = models.UpdateCartItemById(cartItem)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title 添加购物车项
// @router /update [post]
func (c *ShopCartController) UpdateShopCartItem() {
	var cartKey string
	var sku model_views.Sku
	var quantity int

	// cartKey
	if v := c.GetString("cartKey"); v != "" {
		cartKey = v
	}
	// sku
	if v := c.GetString("sku"); v != "" {
		_ = json.Unmarshal([]byte(v), &sku)
	}
	// quantity
	if v := c.GetString("quantity"); v != "" {
		quantity, _ = strconv.Atoi(v)
	}

	cart, err := models.GetCartByCartKey(cartKey)
	if err != nil {
		c.ServerError(err)
		return
	}

	cartItem, err := models.GetCartItemBySkuIdAndCartId(sku.Id, cart.Id)
	if err != nil {
		c.ServerError(err)
		return
	}

	if cartItem.CartId.Id == cart.Id {
		cartItem.Quantity = quantity
		err = models.UpdateCartItemById(cartItem)
		if err != nil {
			c.ServerError(err)
			return
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, nil)
}

// @Title 获取购物车项
// @router / [get]
func (c *ShopCartController) GetShopCartItems() {
	var cartKey string
	var list []interface{}

	cartKey = c.GetString("cartKey")

	if cartKey != "" {
		cart, err := models.GetCartByCartKey(cartKey)
		if err != nil {
			c.ServerError(err)
			return
		}

		var query = make(map[string]string)
		query["DeleteFlag"] = "0"
		query["CartId"] = strconv.Itoa(cart.Id)

		cnt, err := models.GetCartItemCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		l, err := models.GetAllCartItem(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}

		for _, v := range l {
			cartItem := v.(models.CartItem)
			controller := CommonController{}
			cartItemView := controller.SetCartItemByCartItemModel(cartItem)
			list = append(list, cartItemView)
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, list)
}

// @Title 获取购物车数量
// @router /count [get]
func (c *ShopCartController) GetShopCartCount() {
	var cartKey string
	var query = make(map[string]string)
	var count int

	cartKey = c.GetString("cartKey")

	if cartKey != "" {
		cart, err := models.GetCartByCartKey(cartKey)
		if err != nil {
			c.ServerError(err)
			return
		}

		query["DeleteFlag"] = "0"
		query["CartId"] = strconv.Itoa(cart.Id)

		cnt, err := models.GetCartItemCount(query)
		if err != nil {
			c.ServerError(err)
			return
		}

		query := make(map[string]string)
		query["DeleteFlag"] = "0"
		query["CartId"] = strconv.Itoa(cart.Id)

		l, err := models.GetAllCartItem(query, nil, nil, nil, 0, cnt)
		if err != nil {
			c.ServerError(err)
			return
		}

		for _, v := range l {
			cartItem := v.(models.CartItem)
			count = count + cartItem.Quantity
		}
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, count)
}

/**
 * 生成 CartKey UID + MD5
 */
func (c *ShopCartController) generateCartKey() (cartKey string) {
	uidStr := uuid.Must(uuid.NewV4(), nil).String()
	md5Str := helpers.GetMd5String(uidStr)

	return uidStr + "-" + md5Str
}

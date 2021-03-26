package web

import (
	"bee-shop-b2c/common"
	"bee-shop-b2c/common/http"
	"bee-shop-b2c/common/weixin"
	"bee-shop-b2c/helpers"
	"bee-shop-b2c/model_views"
	"bee-shop-b2c/models"
	"time"
)

type WeChatController struct {
	JsonController
}

// URLMapping ...
func (c *WeChatController) URLMapping() {
	c.Mapping("GetAuthorizedCode", c.GetAuthorizedCode)
	c.Mapping("AuthorizedLogin", c.AuthorizedLogin)
}

// @Title 获取授权Code
// @router /authorized-code [get]
func (c *WeChatController) GetAuthorizedCode() {
	officialAccount := weixin.GetOfficialAccount()
	oauth := officialAccount.GetOauth()

	redirectURL, err := oauth.GetRedirectURL("https://www.mifengfeng.com/web/#/login", "snsapi_userinfo", "STATE")
	if err != nil {
		c.ServerError(err)
		return
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, redirectURL)
}

// @Title 授权登录
// @router /authorized-login [get]
func (c *WeChatController) AuthorizedLogin() {
	var code string
	// code
	if v := c.GetString("code"); v != "" {
		code = v
	}

	officialAccount := weixin.GetOfficialAccount()
	oauth := officialAccount.GetOauth()

	result, err := oauth.GetUserAccessToken(code)
	if err != nil {
		c.ServerError(err)
		return
	}

	member, _ := models.GetMemberByOpenId(result.OpenID)

	commonController := &CommonController{}
	var memberView model_views.Member
	if member != nil {
		memberView = commonController.setMemberByMemberModel(*member)
	} else {
		userInfo, err := oauth.GetUserInfo(result.AccessToken, result.OpenID, "")
		if err != nil {
			c.ServerError(err)
			return
		}

		member = &models.Member{}
		member.Name = userInfo.Nickname
		member.OpenId = userInfo.OpenID
		member.Address = userInfo.Country + userInfo.Province + userInfo.City
		member.Avatar = userInfo.HeadImgURL
		member.Gender = int(userInfo.Sex)

		memberRank, err := models.GetMemberRankByDefault()
		if err != nil {
			c.ServerError(err)
			return
		}
		member.MemberRankId = int64(memberRank.Id)

		id, err := models.AddMember(member)
		if err != nil {
			c.ServerError(err)
			return
		}

		member, err := models.GetMemberById(int(id))
		if err != nil {
			c.ServerError(err)
			return
		}
		memberView = commonController.setMemberByMemberModel(*member)
	}

	// 最后登录IP
	member.LoginIp = c.Ctx.Input.IP()
	member.LoginDate = time.Now()

	/**
	 * 设置Cookie
	 */
	c.SetSessionUser(*member)
	var cookieMember CookieMember
	cookieMember.MemberId = member.Id
	cookieMember.Username = member.Username
	cookieMember.Time = time.Now()
	v, err := helpers.Encode(cookieMember)
	if err == nil {
		c.SetSecureCookie(common.AppKey(), "web_login", v, 24*3600)
	}

	c.JsonResult(http.GetHttpStatusByAlias("ok"), http.ErrOK, http.Success, memberView)
}

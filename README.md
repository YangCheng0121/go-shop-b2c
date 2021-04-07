## Go语言 B2C 商城
技术栈：GO、Beego、silenceper/wechat

简单介绍：一个用Go语言Beego框架写的API服务端，用Vue写前端的B2C商城

* [Beego 文档](https://beego.me/)
* [Vue 文档](https://cn.vuejs.org/index.html)

## 演示项目地址
* [移动Web端](http://106.54.82.67/go-shop-web/?#/)
* [管理中心](http://106.54.82.67/go-shop-admin/#/user/login)

## 启动项目
下载到 $GOPATH/src 目录
```
cd $GOPATH/src
git clone https://github.com/CleverBamboo/go-shop-b2c.git
```

然后
```
go mod tidy
```
即会自动对应的包，点击运行

## 目录结构
* common
  公共代码函数  
  
* conf 
  配置文件

* controllers
  Controller层
  
* helpers
  工具函数
  
* model_views
  展示给前端的Struct
  
* routers
  路由
  
* setting
  后台xml配置，go-shop-b2c.xml
 
## 运行
使用 git 下载到 GO的 GOPATH目录
```
git clone https://github.com/CleverBamboo/go-shop-b2c.git
```
然后进入该目录，下载 go.mod的包
```
cd go-shop-b2c
go mod tidy
go get -u -v
```
然后运行即可

PS: **注意实现要先搭建 MySQL、Redis，MySQL要初始化 go-shop-b2c.sql**

建议使用 Docker 安装，教程如下
* [Docker 安装 MySQL](https://www.runoob.com/docker/docker-install-mysql.html)
* [Docker 安装 Redis](https://www.runoob.com/docker/docker-install-redis.html)

## 功能模块
```
- 商品管理
  - 商品管理
  - 库存管理
  - 商品分类
  - 商品标签
  - 商品参数
  - 商品属性
  - 规格管理
  - 品牌管理
  - 到货通知

- 订单管理
  - 订单管理
  - 订单支付
  - 订单退款
  - 订单发货
  - 订单退货
  - 发货点管理
  
- 营销管理
  - 促销管理
  - 优惠券管理

- 会员管理
  - 会员等级
  - 积分管理
  - 预存款
  - 评论管理
  - 咨询管理
  - 消息配置

- 内容管理
  - 广告管理

- 系统设置
  - 系统设置
  - 地区管理
  - 支付方式
  - 配送方式
  - 物流公司
  - 支付插件
  - 存储插件
  - 登录插件
  - 管理员
  - 角色管理
```

## 效果图
### 移动web端
<a href="https://z3.ax1x.com/2021/03/29/c9wyGj.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9wyGj.png" alt="c9wyGj.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wDIg.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9wDIg.png" alt="c9wDIg.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wsiQ.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9wsiQ.png" alt="c9wsiQ.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wdqf.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9wdqf.png" alt="c9wdqf.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wBdS.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9wBdS.png" alt="c9wBdS.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9w6Rs.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9w6Rs.png" alt="c9w6Rs.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wczn.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9wczn.png" alt="c9wczn.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9w2Mq.png" style="display:inline-blcok;"><img wdith="350" height="350" src="https://z3.ax1x.com/2021/03/29/c9w2Mq.png" alt="c9w2Mq.png" border="0"></a>

### 管理端
<a href="https://z3.ax1x.com/2021/03/29/c9sBCD.png"><img src="https://z3.ax1x.com/2021/03/29/c9sBCD.png" alt="c9sBCD.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9sw4O.png"><img src="https://z3.ax1x.com/2021/03/29/c9sw4O.png" alt="c9sw4O.png" border="0"></a>

## 欢迎关注公众号
![](https://z3.ax1x.com/2021/03/31/cFHy1e.gif)
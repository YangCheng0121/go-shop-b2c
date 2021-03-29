## Go语言 B2C 商城
技术栈：GO、Beego、silenceper/wechat

简单介绍：一个用Go语言Beego框架写的API服务端，用Vue写前端的B2C商城

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

PS: 注意实现要先搭建MySQL、Redis，MySQL要初始化 go-shop-b2c.sql

建议使用 Docker 安装，教程如下
*[Docker 安装 MySQL](https://www.runoob.com/docker/docker-install-mysql.html)
*[Docker 安装 Redis](https://www.runoob.com/docker/docker-install-redis.html)
## 效果图
### 移动web端
<a href="https://z3.ax1x.com/2021/03/29/c9wyGj.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9wyGj.png" alt="c9wyGj.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wDIg.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9wDIg.png" alt="c9wDIg.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wsiQ.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9wsiQ.png" alt="c9wsiQ.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wdqf.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9wdqf.png" alt="c9wdqf.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wBdS.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9wBdS.png" alt="c9wBdS.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9w6Rs.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9w6Rs.png" alt="c9w6Rs.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9wczn.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9wczn.png" alt="c9wczn.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9w2Mq.png" style="display:inline-blcok;width:250px;height:250px;"><img src="https://z3.ax1x.com/2021/03/29/c9w2Mq.png" alt="c9w2Mq.png" border="0"></a>

### 管理端
<a href="https://z3.ax1x.com/2021/03/29/c9sBCD.png"><img src="https://z3.ax1x.com/2021/03/29/c9sBCD.png" alt="c9sBCD.png" border="0"></a>
<a href="https://z3.ax1x.com/2021/03/29/c9sw4O.png"><img src="https://z3.ax1x.com/2021/03/29/c9sw4O.png" alt="c9sw4O.png" border="0"></a>

## 公众号
![公众号](https://z3.ax1x.com/2021/03/29/c9sEcj.jpg)
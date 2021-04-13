# gitters

banzhy: GitHub 客户端 App

## 功能

1. 登录功能欢迎页:
   a. 登录功能
   b. 常见问题
   c. 用户反馈
2. 主页列表页展示功能:
   a. Follwing
   b. Follwers
   c. Star
   d. Popular
   e. Mine
3. 搜索页功能:
   a. 与我相关
   b. 公开事件
   c. 搜索功能: 目前支持 User & Repository
4. 个人页功能:
   a. 个人信息展示
   b. 主题切换
   c. 语言切换
   d. 关于应用
5. 仓库列表功能
6. 个人仓库功能
7. Star，Follow 等功能
8. ...

## 个人开发问题记录

### 通用问题

    1.全局Context如何建立，在哪个层级？
    2.怎么既能通过解耦的方式导出BN.Indexs，又能使其满足国际化的需求？

#### 1.Provider 框架的原理

    providers的声明需要在MyApp之上

#### 2.Router 框架的搭建

    application.dart的Router的作用，需要在main方法中就初始化

#### 3.国际化支持的过程中：

    1.没有明白GlobalKey的作用
    2.没有用自定义I18nWidget去包含HomePage
    3.对应着https://www.jianshu.com/p/8356a3bc8f6c，去搞明白其具体意义
    4.如何设置一个可用的全局context

#### 4.Marketplace 的定位为各种仓库的展示(用 Tab 的方式实现，左右滑动：暂定个人仓，关注仓)，所以登录逻辑也提前到应用打开

#### 5.cached_network_image: 图片缓存框架的学习：https://pub.dev/packages/cached_network_image/install

#### 6.fluttertoast:Toast 展示框架：https://pub.dev/packages/fluttertoast/install

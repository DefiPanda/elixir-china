# ElixirChina

目前[ElixirChina 网站](http://120.24.62.150:4000/)部署在阿里云上。如果要本地开发运行ElixirChina，请依次运行以下命令行指令。

`mix deps.get`  
`mix ecto.create Repo`  
`mix ecto.migrate Repo`  
`mix phoenix.start`  

在浏览器输入 `localhost:4000` 就能访问网站啦。

## 想实现的功能
- 论坛基本功能
  - [x] 发帖
  - [x] 贴内评论
  - [x] 用户注册
  - [x] 用户登录
  - [x] session验证
  - [x] 用户管理自己发的贴
  - [x] 任意用户的帖子汇总页面
  - [ ] 添加管理员

- UI设计
  - [ ] 主页帖子分页
  - [x] css美化

- 论坛高级功能
  - [x] 帖子分类
  - [x] 添加用户积分
  - [x] 评论有回复时在消息中心提示
  - [x] 帖子有回复时在消息中心提示
  - [ ] 添加版主

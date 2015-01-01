# ElixirChina  
[![Build Status](https://travis-ci.org/jw2013/elixir-china.svg)](https://travis-ci.org/jw2013/elixir-china)

目前[ElixirChina 网站](http://elixir-cn.com/)部署在DigitalOcean上。如果要本地开发运行ElixirChina，请依次运行以下命令行指令。

`mix deps.get`  
`mix ecto.create Repo`  
`mix ecto.migrate Repo`  
`mix phoenix.start`  

在浏览器输入 `localhost:4000` 就能访问网站啦。

## 贡献
如果你想为ElixirChina贡献代码，可以来[Issue list](https://github.com/jw2013/elixir-china/issues)完成那里的一个个issue，另一种方式就是实现下面`想实现的功能`板块中还没实现的功能。完成后请提交[Pull request](https://github.com/jw2013/elixir-china/pulls)。
  
任何贡献：小到修复错别字，大到修复严重的bug或者实现比较大的功能，都非常的欢迎。  

:heart: :green_heart: :blue_heart: :yellow_heart: :purple_heart:

## 想实现的功能
- 论坛基本功能
  - [x] 发帖
  - [x] 贴内评论
  - [x] 用户注册
  - [x] 用户登录
  - [x] session验证
  - [x] 用户管理自己发的贴
  - [x] 任意用户的帖子汇总页面

- UI设计
  - [x] 主页帖子分页
  - [x] css美化
  - [x] 支持显示所有的[Github Emoji](http://www.emoji-cheat-sheet.com/)

- 论坛高级功能
  - [x] 帖子分类
  - [x] 添加用户积分
  - [x] 帖子有回复时在消息中心提示
  - [x] 支持Markdown编辑和显示
  - [x] 点击回复评论能@某用户，并在被@的用户的消息中心提示

- 管理功能
  - [ ] 添加版主
  - [ ] 添加管理员

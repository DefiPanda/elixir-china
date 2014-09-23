# ElixirChina

如果要本地开发运行ElixirChina，请依次运行以下命令行指令。

1. `mix deps.get`
2. `mix ecto.create Repo`
3. `mix ecto.migrate Repo`
4. `mix phoenix.start`

在浏览器输入 `localhost:4000` 就能访问网站啦。

## 想实现的功能
- 论坛基本功能
  - [x] 发帖
  - [x] 贴内评论
  - [x] 用户注册
  - [ ] 用户登录
  - [ ] session验证
  - [ ] 用户管理自己发的贴
  - [ ] 添加管理员

- UI设计
  - [ ] 主页帖子分页
  - [ ] css美化

- 论坛高级功能
  - [ ] 添加用户积分
  - [ ] 添加版主

# ElixirChina

如果要本地开发运行ElixirChina，请依次运行以下命令行指令。

1. `mix deps.get`
2. `mix ecto.create Repo`
3. `mix ecto.migrate Repo`
4. `mix phoenix.start`

在浏览器输入 `localhost:4000` 就能访问网站啦。
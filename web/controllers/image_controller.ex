defmodule ElixirChina.ImageController do
  use ElixirChina.Web, :controller
  @prefix "image"

  def create(conn, params) do
    filename = generate_filename(params["file"])
    case ElixirChina.Uploader.upload(params["file"].path, filename) do
      {:ok, url} ->
        json conn, %{filename: url}
      {:error, reason} ->
        conn
        |> put_status(400)
        |> json(%{error: reason})
    end
  end

  defp generate_filename(upload) do
    md5 = Base.encode16(:erlang.md5(upload.path), case: :lower)
    ext = upload.content_type |> String.split("/") |> List.last
    [@prefix, "/", md5, ".", ext] |> Enum.join
  end
end

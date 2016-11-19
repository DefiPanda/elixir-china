defmodule ElixirChina.Uploader do
  def upload(path, filename \\ "", uploader \\ ElixirChina.QiniuUploader) do
    uploader.upload(path, filename)
  end
end

defmodule ElixirChina.QiniuUploader do
  def upload(path, key) do
    put_policy = Qiniu.PutPolicy.build(Qiniu.config[:bucket])

    res = Qiniu.Uploader.upload put_policy, path, key: key
    if res.status_code >= 200 && res.status_code < 300 do
      url = Path.join("http://" <> Qiniu.config[:domain], res.body["key"])
      {:ok, url}
    else
      {:error, "Fail to upload!"}
    end
  end
end

defmodule ElixirChina.UserView do
  use ElixirChina.View

  def human_error({field, {:too_short, len}}), do: "#{field} 不能小于#{len}"
  def human_error({field, :format}), do: "#{field}格式不对"
  def human_error({field, :required}), do: "#{field} 不能为空"
  def human_error({field, :exclusion}), do: "#{field} 值不被允许"
end

defmodule Koubo.Web.PageView do
  use Koubo.Web, :view

  @title Application.get_env(:koubo, :site_name)

  def title("box.html", %{name: name}), do: "#{name}の箱 - #{@title}"
  def title(_, _), do: @title

  def description("box.html", %{name: name}), do: """
  #{name}の箱に匿名で何かを恵もう！
  """
  def description(_, _), do: """
  匿名で箱を作ろう！
  """

  def url(conn) do
    scheme = case conn.scheme do
      :http -> "http"
      :https -> "https"
    end
    host = conn.host
    path = conn.request_path
    "#{scheme}://#{host}#{path}"
  end
end

defmodule Koubo.Web.PageController do
  use Koubo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def box(conn, %{"name" => name}) do
    items = Koubo.Box.get_items(name)
    render conn, "box.html", name: name, items: items
  end

  def create_box(conn, %{"name" => name}) do
    redirect conn, to: "/#{name}"
  end

  def ask(conn, %{"name" => box, "item" => item}) do
    Koubo.Box.ask(box, item)
    redirect conn, to: "/#{box}"
  end

  def give(conn, %{"name" => box, "item" => item}) do
    Koubo.Box.give(box, item)
    redirect conn, to: "/#{box}"
  end
end

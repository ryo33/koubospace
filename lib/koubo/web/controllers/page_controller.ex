defmodule Koubo.Web.PageController do
  use Koubo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def box(conn, %{"name" => name}) do
    import Ecto.Query
    alias Koubo.Box.Item
    query = from i in Item,
      where: i.box == ^name,
      group_by: i.item,
      order_by: [desc: count(i.id)],
      select: {i.item, count(i.id)}
    items = Koubo.Repo.all(query)
    render conn, "box.html", name: name, items: items
  end

  def create_box(conn, %{"name" => name}) do
    redirect conn, to: "/#{name}"
  end

  def ask(conn, %{"name" => box, "item" => item}) do
    import Ecto.Query
    alias Koubo.Box.Item
    query = from i in Item,
      where: i.box == ^box,
      where: i.item == ^item
    if Koubo.Repo.aggregate(query, :count, :id) == 0 do
      changeset = Item.changeset(%Item{}, %{box: box, item: item})
      Koubo.Repo.insert!(changeset)
    end
    redirect conn, to: "/#{box}"
  end

  def give(conn, %{"name" => box, "item" => item}) do
    alias Koubo.Box.Item
    changeset = Item.changeset(%Item{}, %{box: box, item: item})
    Koubo.Repo.insert!(changeset)
    redirect conn, to: "/#{box}"
  end
end

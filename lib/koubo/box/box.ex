defmodule Koubo.Box do
  import Ecto.Query
  alias Koubo.Box.Item
  alias Koubo.Box.ItemLog
  alias Ecto.Multi

  def get_items(box) do
    query = from i in Item,
      where: i.box == ^box,
      order_by: [desc: i.count],
      select: [:item, :count]
    Koubo.Repo.all(query)
  end

  def ask(box, item) do
    query = from i in Item,
      where: i.box == ^box,
      where: i.item == ^item
    if Koubo.Repo.aggregate(query, :count, :id) == 0 do
      changeset = Item.changeset(%Item{}, %{box: box, item: item, count: 0})
      Koubo.Repo.insert!(changeset)
    end
  end

  def give(box, item) do
    changeset = ItemLog.changeset(%ItemLog{}, %{box: box, item: item})
    item_query = from i in Item,
      where: i.box == ^box,
      where: i.item == ^item,
      update: [inc: [count: 1]]
    multi = Multi.new
            |> Multi.insert(:log, changeset)
            |> Multi.update_all(:increment, item_query, [])
    {:ok, _} = Koubo.Repo.transaction(multi)
  end
end

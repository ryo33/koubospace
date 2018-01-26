defmodule Koubo.Repo.Migrations.CreateBoxItems do
  use Ecto.Migration

  import Ecto.Query
  alias Koubo.Box.Item
  alias Koubo.Box.ItemLog

  def up do
    create table(:box_items) do
      add :box, :string
      add :item, :string
      add :count, :integer

      timestamps()
    end

    flush()

    create_items()
  end
  
  defp create_items() do
    query = from i in ItemLog,
      group_by: [:box, :item],
      select: {i.box, i.item, count(i.id)}
    items = Koubo.Repo.all(query)
    Enum.each(items, fn {box, item, count} ->
      first_log = get_first_log(box, item)
      item = %Item{
        box: box,
        item: item,
        count: count - 1, # Ignores the first log
        inserted_at: first_log.inserted_at,
        updated_at: first_log.updated_at
      }
      Koubo.Repo.insert!(item)
      Koubo.Repo.delete!(first_log)
    end)
  end

  defp get_first_log(box, item) do
    query = from i in ItemLog,
      where: i.box == ^box,
      where: i.item == ^item,
      order_by: [asc: i.inserted_at],
      limit: 1
    Koubo.Repo.one!(query)
  end
end

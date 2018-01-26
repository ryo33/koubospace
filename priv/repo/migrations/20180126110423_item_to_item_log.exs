defmodule Koubo.Repo.Migrations.ItemToItemLog do
  use Ecto.Migration

  def change do
    rename table("box_items"), to: table("box_item_logs")
  end
end

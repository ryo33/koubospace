defmodule Koubo.Repo.Migrations.DropItemLog do
  use Ecto.Migration

  def change do
    drop table("box_item_logs")
  end
end

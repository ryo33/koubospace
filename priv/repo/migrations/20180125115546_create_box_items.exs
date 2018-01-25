defmodule Koubo.Repo.Migrations.CreateBoxItems do
  use Ecto.Migration

  def change do
    create table(:box_items) do
      add :box, :string
      add :item, :string

      timestamps()
    end

  end
end

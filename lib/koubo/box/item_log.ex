defmodule Koubo.Box.ItemLog do
  use Ecto.Schema
  import Ecto.Changeset
  alias Koubo.Box.ItemLog

  schema "box_item_logs" do
    field :box, :string
    field :item, :string

    timestamps()
  end

  @doc false
  def changeset(%ItemLog{} = item, attrs) do
    item
    |> cast(attrs, [:box, :item])
    |> validate_required([:box, :item])
  end
end

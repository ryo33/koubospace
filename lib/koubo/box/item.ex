defmodule Koubo.Box.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias Koubo.Box.Item


  schema "box_items" do
    field :box, :string
    field :item, :string

    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:box, :item])
    |> validate_required([:box, :item])
  end
end

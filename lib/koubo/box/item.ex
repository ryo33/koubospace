defmodule Koubo.Box.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias Koubo.Box.Item

  schema "box_items" do
    field :box, :string
    field :count, :integer
    field :item, :string

    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:box, :item, :count])
    |> validate_required([:box, :item, :count])
  end
end

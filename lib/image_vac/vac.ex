defmodule ImageVac.Vac do
  use Ecto.Schema
  import Ecto.Changeset
  alias ImageVac.Vac


  schema "vacs" do
    field :hash_id, :string
    timestamps()
  end

  @doc false
  def changeset(%Vac{} = vac, attrs) do
    vac
    |> cast(attrs, [])
    |> validate_required([])
  end
end

defmodule ImageVac.Vac do
  use Ecto.Schema
  import Ecto.Changeset
  alias ImageVac.Vac

  schema "vacs" do
    has_many :images, ImageVac.Image
    field :hash_id, :string
    field :url, :string
    timestamps()
  end

  @doc false
  def changeset(%Vac{} = vac, attrs \\ %{}) do
    vac
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end

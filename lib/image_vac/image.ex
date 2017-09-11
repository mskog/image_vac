defmodule ImageVac.Image do
  use Ecto.Schema
  import Ecto.Changeset
  alias ImageVac.Image

  schema "images" do
    belongs_to :vac, ImageVac.Vac
    field :url, :string
    timestamps()
  end

  @doc false
  def changeset(%Image{} = image, attrs \\ %{}) do
    image
    |> cast(attrs, [:url])
    |> validate_required([:url, :vac_id])
  end
end

defmodule ImageVac.Vac do
  use Ecto.Schema
  import Ecto.Changeset
  alias ImageVac.Vac

  schema "vacs" do
    has_many(:images, ImageVac.Image)
    field(:hash_id, :string)
    field(:url, :string)
    timestamps()
  end

  @doc false
  def changeset(%Vac{} = vac, attrs \\ %{}) do
    vac
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> validate_url_format
  end

  defp validate_url_format(changeset) do
    url = get_field(changeset, :url)

    case validate_url(url) do
      {:ok, _} ->
        changeset

      {:error, _} ->
        add_error(changeset, :url, "invalid")
    end
  end

  defp validate_url(nil = url) do
    {:ok, url}
  end

  defp validate_url(url) do
    ImageVac.Helpers.UrlValidator.valid_url(url)
  end
end

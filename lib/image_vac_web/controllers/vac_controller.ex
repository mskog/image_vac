defmodule ImageVacWeb.VacController do
  use ImageVacWeb, :controller

  alias ImageVac.Vac
  alias ImageVac.Repo

  def new(conn, _params) do
    changeset = Vac.changeset(%Vac{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vac" => vac}) do
    {:ok, url} = Map.fetch(vac, "url")
    attributes = %{url: ImageVac.Helpers.Url.build_url(url)}
    changeset = Vac.changeset(%Vac{}, attributes)

    case Repo.insert(changeset) do
      {:ok, vac} ->
        changes = Ecto.Changeset.change(vac, hash_id: ImageVac.Hashes.encode(vac.id))
        {:ok, vac} = Repo.update(changes)

        conn
        |> redirect(to: vac_path(conn, :show, vac.hash_id))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => hash_id}) do
    vac = Repo.get_by!(Vac, hash_id: hash_id) |> Repo.preload(:images)

    image_urls =
      ImageVac.Images.filter_too_small(vac.images)
      |> ImageVac.Images.image_urls()

    Task.async(fn ->
      ImageVac.Images.fetch_and_persist(vac.url, vac)
    end)

    render(conn, "show.html", vac: vac, image_urls: image_urls)
  end
end

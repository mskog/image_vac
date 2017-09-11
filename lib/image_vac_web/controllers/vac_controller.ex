defmodule ImageVacWeb.VacController do
  use ImageVacWeb, :controller

  alias ImageVac.Vac
  alias ImageVac.Repo

  def new(conn, _params) do
    changeset = Vac.changeset(%Vac{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"vac" => vac}) do
    changeset = Vac.changeset(%Vac{}, vac)

    case Repo.insert(changeset) do
      {:ok, vac} ->
        changes = Ecto.Changeset.change vac, hash_id: ImageVac.Hashes.encode(vac.id)
        {:ok, vac} = Repo.update(changes)
        conn
        |> redirect(to: vac_path(conn, :show, vac.hash_id))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => hash_id}) do
    vac = Repo.get_by!(Vac, hash_id: hash_id) |> Repo.preload(:images)
    url = "https://zucker.mskog.com/images?url=#{vac.url}"

    Task.async fn ->
      new_images = ImageVac.Images.fetch(url)
      |> ImageVac.Images.remove_duplicate_urls(vac.images)
      |> Enum.take(10)
      |> ImageVac.Images.persist_images(vac)
      |> Enum.map(fn image -> image.url end)
      ImageVacWeb.Endpoint.broadcast "vac:images:#{vac.hash_id}", "new_images", %{images: new_images}
    end

    render conn, "show.html", vac: vac
  end
end

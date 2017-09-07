defmodule ImageVacWeb.VacController do
  use ImageVacWeb, :controller
  use Drab.Controller

  alias ImageVac.Vac
  alias ImageVac.Repo

  def new(conn, _params) do
    changeset = Vac.changeset(%Vac{})
    render conn, "new.html", changeset: changeset, welcome_text: "Welcome to Phoenix!"
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
    vac = Repo.get_by!(Vac, hash_id: hash_id)
    images = []

    render conn, "show.html", images: images, vac: vac
  end
end

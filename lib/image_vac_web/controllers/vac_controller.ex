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
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: vac_path(conn, :show, vac.id))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => vac_id}) do
    vac = Repo.get!(Vac, vac_id)
    url = "https://zucker.mskog.com/images?url=#{vac.url}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], recv_timeout: 20000)

    images = Poison.decode!(body)
    |> Enum.take(10)
    |> Enum.map(&ImageVac.Thumbs.image_url/1)

    render conn, "show.html", images: images
  end
end

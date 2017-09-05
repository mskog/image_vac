defmodule ImageVacWeb.VacController do
  use ImageVacWeb, :controller

  def index(conn, params) do
    url = "https://zucker.mskog.com/images?url=#{params["url"]}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], recv_timeout: 10000)

    images = Poison.decode!(body)
    |> Enum.take(10)
    |> Enum.map(&ImageVac.Thumbs.image_url/1)

    render conn, "index.html", images: images
  end
end

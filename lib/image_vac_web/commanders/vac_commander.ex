defmodule ImageVacWeb.VacCommander do
  use Drab.Commander

  # Drab Callbacks
  def fetch_images(socket, _sender) do
    vac = Drab.Live.peek(socket, :vac)
    url = "https://zucker.mskog.com/images?url=#{vac.url}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], recv_timeout: 20000)
    images = Poison.decode!(body)
    |> Enum.take(10)
    |> Enum.map(&ImageVac.Thumbs.image_url/1)

    Drab.Live.poke socket, images: images
  end
end

defmodule ImageVac.Images do
  def fetch(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], recv_timeout: 20000)

    Poison.decode!(body)
    |> Enum.take(10)
    |> Enum.map(&ImageVac.Thumbs.image_url/1)
  end
end

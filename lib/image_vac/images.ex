defmodule ImageVac.Images do
  def fetch(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], recv_timeout: 20000)

    Poison.decode!(body)
    |> Enum.map(&ImageVac.Thumbs.image_url/1)
  end

  def persist_images(image_urls, vac) do
    Enum.map image_urls, fn image_url ->
      {:ok, image} = ImageVac.Repo.insert(%ImageVac.Image{url: image_url, vac_id: vac.id})
      image
    end
  end

  def remove_duplicate_urls(image_urls, images) do
    image_urls -- Enum.map(images, fn image -> image.url end)
  end
end

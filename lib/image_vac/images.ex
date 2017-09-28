defmodule ImageVac.Images do
  def fetch_and_persist(url, vac) do
    images = fetch(url)
    |> remove_duplicate_urls(vac.images)
    Enum.chunk_every(images, round(Enum.count(images)/4)+1)
    |> Enum.each(fn images_chunk ->
      Task.async fn ->
        persist_images(images_chunk, vac)
      end
    end)
  end

  def fetch(url) do
    zucker_url = "https://zucker.mskog.com/images?url=#{url}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(zucker_url, [], recv_timeout: 30000)
    Poison.decode!(body)
  end

  def persist_images(image_urls, vac) do
    Enum.map image_urls, fn image_url ->
      {:ok, image} = case HTTPoison.get("https://zucker.mskog.com/imageproperties?url=#{image_url}", [], recv_timeout: 30000) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          case Poison.decode!(body) do
            %{"height" => height, "width" => width, "type" => type} ->
              ImageVac.Repo.insert(%ImageVac.Image{url: image_url, vac_id: vac.id, height: height, width: width, type: type})
            _ ->
              # ImageVac.Repo.insert(%ImageVac.Image{url: image_url, vac_id: vac.id})
          end
        {:ok, %HTTPoison.Response{status_code: _, body: _}} ->
          # ImageVac.Repo.insert(%ImageVac.Image{url: image_url, vac_id: vac.id})
      end

      broadcast_new_images(vac, [image])
      image
    end
  end

  def remove_duplicate_urls(image_urls, images) do
    image_urls -- Enum.map(images, fn image -> image.url end)
  end

  def filter_too_small(images) do
    Enum.reject images, fn image ->
      image.width != nil && image.height < 200
    end
  end

  def image_urls(images) do
    Enum.map images, fn image ->
      %ImageVac.ImageUrl{
        url: ImageVac.Thumbs.image_url(image.url),
        thumbnail_url: ImageVac.Thumbs.thumbnail_url(image.url),
        thumbnail_height: image.height,
        thumbnail_width: image.width,
      }
    end
  end

  defp broadcast_new_images(vac, images) do
    urls = filter_too_small(images)
    |> image_urls
    ImageVacWeb.Endpoint.broadcast "vac:images:#{vac.hash_id}", "new_images", %{images: urls}
  end
end

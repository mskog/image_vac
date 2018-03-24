defmodule ImageVac.Thumbs do
  @thumbor_url Application.get_env(:image_vac, :thumbs_url)

  def image_url(url) do
    "#{@thumbor_url}/#{URI.encode(url, &URI.char_unreserved?(&1))}"
  end

  def thumbnail_url(url, height \\ 300) do
    "#{@thumbor_url}/x#{height}/#{URI.encode(url, &URI.char_unreserved?(&1))}"
  end
end

defmodule ImageVac.Thumbs do
  @thumbor_url "https://thumbs.picyo.me"

  def image_url(url) do
    "#{@thumbor_url}/#{url}"
  end

  def thumbnail_url(url, height \\ 200) do
    "#{@thumbor_url}/x#{height}/#{url}"
  end
end

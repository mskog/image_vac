defmodule ImageVac.Thumbs do
  @thumbor_url "https://thumbs.picyo.me"

  def image_url(url) do
    "#{@thumbor_url}/#{url}"
  end

  def thumbnail_url(url, width \\ 300) do
    "#{@thumbor_url}/#{width}x/#{url}"
  end
end

defmodule ImageVac.Thumbs do
  @thumbor_url "https://thumbs.picyo.me"

  def image_url(url) do
    "#{@thumbor_url}/300x/#{url}"
  end
end

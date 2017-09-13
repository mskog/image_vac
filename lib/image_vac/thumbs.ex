defmodule ImageVac.Thumbs do
  @thumbor_url "https://thumbs.picyo.me"

  def image_url(url) do
    "#{@thumbor_url}/200x/#{url}"
  end
end

defmodule ImageVac.ThumbsTest do
  use ExUnit.Case, async: true

  def thumbs_url do
    Application.get_env(:image_vac, :thumbs_url)
  end

  describe "image_url/1" do
    test "url" do
      url = "http://www.example.com/image.png"
      assert ImageVac.Thumbs.image_url(url) == "#{ImageVac.ThumbsTest.thumbs_url}/#{url}"
    end
  end

  describe "thumbnail_url/2" do
    test "with default size" do
      url = "http://www.example.com/image.png"
      assert ImageVac.Thumbs.thumbnail_url(url) == "#{ImageVac.ThumbsTest.thumbs_url}/x300/#{url}"
    end

    test "with given size" do
      url = "http://www.example.com/image.png"
      size = 500
      assert ImageVac.Thumbs.thumbnail_url(url, size) == "#{ImageVac.ThumbsTest.thumbs_url}/x#{size}/#{url}"
    end
  end

end

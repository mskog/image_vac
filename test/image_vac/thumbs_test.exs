defmodule ImageVac.ThumbsTest do
  use ExUnit.Case, async: true

  def thumbs_url do
    Application.get_env(:image_vac, :thumbs_url)
  end

  describe "image_url/1" do
    test "url" do
      url = "http://www.example.com/image.png"
      encoded_url = URI.encode(url, &URI.char_unreserved?(&1))

      assert ImageVac.Thumbs.image_url(url) ==
               "#{ImageVac.ThumbsTest.thumbs_url()}/#{encoded_url}"
    end
  end

  describe "thumbnail_url/2" do
    test "with default size" do
      url = "http://www.example.com/image.png"
      encoded_url = URI.encode(url, &URI.char_unreserved?(&1))

      assert ImageVac.Thumbs.thumbnail_url(url) ==
               "#{ImageVac.ThumbsTest.thumbs_url()}/x300/#{encoded_url}"
    end

    test "with given size" do
      url = "http://www.example.com/image.png"
      encoded_url = URI.encode(url, &URI.char_unreserved?(&1))
      size = 500

      assert ImageVac.Thumbs.thumbnail_url(url, size) ==
               "#{ImageVac.ThumbsTest.thumbs_url()}/x#{size}/#{encoded_url}"
    end
  end
end

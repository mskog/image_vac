defmodule ImageVacWeb.VacView do
  use ImageVacWeb, :view

  def title(:show, conn) do
    "All images from #{conn.assigns.vac.url}"
  end

  def image_urls(:show, conn) do
    Enum.map(conn.assigns.image_urls, fn image_url ->
      image_url.url
    end)
    |> Enum.join(",")
  end

  # def image(:show, conn) do
  #   Enum.at(conn.assigns.image_urls, 0).thumbnail_url
  # end
end

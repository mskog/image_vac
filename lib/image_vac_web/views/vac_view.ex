defmodule ImageVacWeb.VacView do
  use ImageVacWeb, :view

  def title(:show, conn) do
    "All images from #{conn.assigns.vac.url}"
  end

  # def image(:show, conn) do
  #   Enum.at(conn.assigns.image_urls, 0).thumbnail_url
  # end
end

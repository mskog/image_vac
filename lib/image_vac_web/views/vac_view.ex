defmodule ImageVacWeb.VacView do
  use ImageVacWeb, :view

  def title(:show, conn) do
    "All images from #{conn.assigns.vac.url}"
  end
end

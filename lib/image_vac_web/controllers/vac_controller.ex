defmodule ImageVacWeb.VacController do
  use ImageVacWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

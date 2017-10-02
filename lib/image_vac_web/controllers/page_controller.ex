defmodule ImageVacWeb.PageController do
  use ImageVacWeb, :controller

  def tos(conn, _params) do
    render conn, "tos.html"
  end
end

defmodule ImageVacWeb.LayoutView do
  use ImageVacWeb, :view

  def title(conn, default) do
    try do
      apply(view_module(conn), :title, [action_name(conn), conn])
    rescue
      _ -> default
    end
  end

  def image(conn, default) do
    try do
      apply(view_module(conn), :image, [action_name(conn), conn])
    rescue
      _ -> default
    end
  end
end

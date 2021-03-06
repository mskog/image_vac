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

  def js_script_tag(conn) do
    if Mix.env == :prod do
      path = static_path(conn, "/js/app.js")
      ~s(<script src="#{path}"></script>)
    else
      ~s(<script src="http://localhost:8080/js/app.js"></script>)
    end
  end

  def css_link_tag(conn) do
    if Mix.env == :prod do
      path = static_path(conn, "/css/app.css")
      ~s(<link rel="stylesheet" type="text/css" href="#{path}" media="screen,projection" />)
    else
      ""
    end
  end
end

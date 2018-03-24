defmodule ImageVac.Helpers.Url do
  def build_url(url_like) do
    case Regex.match?(~r/https?:\/\//, url_like) do
      true ->
        url_like

      false ->
        "http://#{url_like}"
    end
  end
end

defmodule ImageVac.Helpers.UrlValidator do
  def valid_url(url) do
    case URI.parse(url) do
      %URI{scheme: nil} -> {:error, "No scheme"}
      %URI{host: nil, path: nil} -> {:error, "No host or path"}
      _ -> {:ok, url}
    end
  end
end

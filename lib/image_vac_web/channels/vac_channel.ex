defmodule ImageVacWeb.VacChannel do
  use Phoenix.Channel

  def join("vac:images:" <> _, _message, socket) do
    {:ok, socket}
  end

  def join("vac:" <> _, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end

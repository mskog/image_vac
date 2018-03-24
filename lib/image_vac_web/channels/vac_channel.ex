defmodule ImageVacWeb.VacChannel do
  use Phoenix.Channel

  def join("vac:images:" <> vac_id, _message, socket) do
    {:ok, socket}
  end

  def join("vac:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end

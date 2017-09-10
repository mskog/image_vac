defmodule ImageVacWeb.VacChannel do
  use Phoenix.Channel

  def join("vac:images:" <> vac_id, _message, socket) do
    IO.inspect(vac_id)
    {:ok, socket}
  end

  def join("vac:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_out("new_images", msg, socket) do
    IO.inspect(socket)
    IO.inspect msg
    IO.inspect "handled"
    push socket, "new_image", msg
    {:noreply, socket}
  end
end

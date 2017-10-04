defmodule ImageVacWeb.Router do
  use ImageVacWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(_conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    Rollbax.report(kind, reason, stacktrace)
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ImageVacWeb do
    pipe_through :browser # Use the default browser stack

    get "/tos", PageController, :tos

    resources "/", VacController, only: [:show, :new, :create]

    get "/", VacController, :new
  end


  # Other scopes may use custom stacks.
  # scope "/api", ImageVacWeb do
  #   pipe_through :api
  # end
end

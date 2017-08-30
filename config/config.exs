# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration

# Configures the endpoint
config :image_vac, ImageVacWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6LUZksuXezrKQNBOeAVVzSm2jXC8Gz6ezYRE75K8U/TWF7ETJYtfNH+v4RdsN0Rh",
  render_errors: [view: ImageVacWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ImageVac.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

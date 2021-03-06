# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :koubo,
  ecto_repos: [Koubo.Repo]

config :koubo,
  site_name: "酵母スペース"

# Configures the endpoint
config :koubo, Koubo.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oT7DoyZwu9zZHGzoT24loes87gnIRiIN/muJexHd9I1diUKVM5llhMrEvpRbWEk3",
  render_errors: [view: Koubo.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Koubo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

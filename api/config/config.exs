# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :money_tracker,
  ecto_repos: [MoneyTracker.Repo]

# Configures the endpoint
config :money_tracker, MoneyTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v8A5XeapjukHXLd/WYkjqExw6mC4kSd1fWs+wnqbi5zm34BggnnfKEOdo3AWErGr",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: MoneyTracker.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "faJR1RZZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

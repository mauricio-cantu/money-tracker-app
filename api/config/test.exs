use Mix.Config

# Configure your database
config :money_tracker, MoneyTracker.Repo,
  username: "root",
  password: "root",
  database: "money_tracker_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :money_tracker, MoneyTrackerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

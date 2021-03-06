# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :events_api,
  ecto_repos: [EventsApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :events_api, EventsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V1STh29BTwTgP5VHFKdWDxNuRFxMjsi34IDyeFKMIeQqHiyOOOSCWkrx7p/gUmZd",
  render_errors: [view: EventsApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: EventsApi.PubSub,
  live_view: [signing_salt: "FhtSL8uw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# config guardian
config :events_api, EventsApiWeb.Auth.Guardian,
  issuer: "events_api",
  secret_key: System.get_env("GUARDIAN_SECRET") || "1321231"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

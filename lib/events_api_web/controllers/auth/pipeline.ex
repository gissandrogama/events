defmodule EventsApiWeb.Auth.Pipeline do
  @moduledoc """
  Module of pipeline guardian
  """
  alias EventsApiWeb.Auth

  use Guardian.Plug.Pipeline,
    otp_app: :blog_api,
    module: Auth.Guardian,
    error_handler: Auth.ErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug Guardian.Plug.EnsureAuthenticated
end

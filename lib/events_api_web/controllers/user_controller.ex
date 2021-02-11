defmodule EventsApiWeb.UserController do
  use EventsApiWeb, :controller

  alias EventsApi.Accounts

  action_fallback EventsApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user)
    end
  end
end

defmodule EventsApiWeb.UserController do
  use EventsApiWeb, :controller

  alias EventsApi.Accounts

  action_fallback EventsApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with user <- Accounts.get_user!(id) do
      render(conn, "show.json", user: user)
    end
  end
end

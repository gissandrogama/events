defmodule EventsApiWeb.UserController do
  use EventsApiWeb, :controller

  alias EventsApi.Accounts
  alias EventsApiWeb.Auth.Guardian

  action_fallback EventsApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user_auth.json", user: user, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user!(id) do
      render(conn, "show.json", user: user)
    end
  end
end

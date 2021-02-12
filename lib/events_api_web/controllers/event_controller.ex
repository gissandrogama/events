defmodule EventsApiWeb.EventController do
  use EventsApiWeb, :controller

  alias EventsApi.Doings

  action_fallback EventsApiWeb.FallbackController

  def index(conn, _params) do
    with events <- Doings.list_events() do
      render(conn, "index.json", events: events)
    end
  end

  def create(conn, %{"event" => event_params}) do
    user = Guardian.Plug.current_resource(conn)

    event_params = Map.put(event_params, "user_id", user.id)

    with {:ok, event} <- Doings.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, event} <- Doings.get_event!(id) do
      render(conn, "show.json", event: event)
    end
  end
end

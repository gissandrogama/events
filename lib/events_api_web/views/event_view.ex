defmodule EventsApiWeb.EventView do
  use EventsApiWeb, :view
  alias EventsApiWeb.EventView

  def render("index.json", %{events: events}) do
    render_many(events, EventView, "event.json")
  end

  def render("show.json", %{event: event}) do
    render_one(event, EventView, "event.json")
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      title: event.title,
      date_initial: event.date_initial,
      date_finish: event.date_finish,
      description: event.description,
      start_time: event.start_time,
      end_time: event.end_time,
      place: event.place,
      andress: event.andress,
      url_img: event.url_img,
      user_id: event.user_id
    }
  end
end

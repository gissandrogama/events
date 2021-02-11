defmodule EventsApiWeb.UserView do
  use EventsApiWeb, :view
  alias EventsApiWeb.UserView

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      nome: user.name,
      email: user.email
    }
  end
end

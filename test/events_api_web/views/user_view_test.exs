defmodule EventsApiWeb.UserViewTest do
  use ExUnit.Case, async: true

  alias EventsApiWeb.UserView

  test "render/2 returns show user" do
    user = %{
      id: "1",
      name: "some displayName",
      email: "some@email.com",
      password: "123123"
    }

    assert %{
             id: "1",
             nome: "some displayName",
             email: "some@email.com"
           } = UserView.render("show.json", %{user: user})
  end
end

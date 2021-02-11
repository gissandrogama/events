defmodule EventsApiWeb.EnvetControllerTest do
  use EventsApiWeb.ConnCase, async: true

  import EventsApi.UserFixture
  alias EventsApi.Doings

  setup %{conn: conn} do
    conn = conn

    %{conn: conn}
  end

  @valid_event %{
    title: "Inteligência Emocional",
    date_initial: "20-10-2021",
    date_finish: "25-10-2021",
    description:
      "Todas as técnicas e ferramentas que vamos apresentar na palestra é 100% baseada na neurociência e nos estudos do comportamento humano.Se você não está satisfeito com a vida, então prepare-se para vivenciar o novo. Além dos aprendizados que você vai absorver, você também vai concorrer a sorteios de mentoria e livros. Então, participe! Não perca mais essa oportunidade na sua vida.",
    start_time: "09:00",
    end_time: "12:00",
    place: "Hangar",
    andress: "Av. Dr. Freitas 8888",
    url_img: "url img",
    user_id: ""
  }

  describe "index" do
    test "listar todos os eventos", %{conn: conn} do
      user = user_fixture()
      params = Map.put(@valid_event, :user_id, user.id)
      Doings.create_event(params)

      conn = get(conn, Routes.event_path(conn, :index))

      assert json_response(conn, 200) |> Enum.count() == 1
    end
  end

  describe "show" do
    test "returnar um evento pelo id", %{conn: conn} do
      user = user_fixture()
      params = Map.put(@valid_event, :user_id, user.id)
      {:ok, event} = Doings.create_event(params)

      conn = get(conn, Routes.event_path(conn, :show, event.id))

      assert %{"id" => id} = json_response(conn, 200)
      assert id == event.id
    end
  end

  describe "create/2" do
    test "retornar um evento quando parametros validos", %{conn: conn} do
      user = user_fixture()
      params = Map.put(@valid_event, :user_id, user.id)
      conn = post(conn, Routes.event_path(conn, :create), event: params)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.event_path(conn, :show, id))

      assert %{
               "id" => _,
               "title" => "Inteligência Emocional",
               "date_initial" => "20-10-2021",
               "date_finish" => "25-10-2021",
               "description" =>
                 "Todas as técnicas e ferramentas que vamos apresentar na palestra é 100% baseada na neurociência e nos estudos do comportamento humano.Se você não está satisfeito com a vida, então prepare-se para vivenciar o novo. Além dos aprendizados que você vai absorver, você também vai concorrer a sorteios de mentoria e livros. Então, participe! Não perca mais essa oportunidade na sua vida.",
               "start_time" => "09:00",
               "end_time" => "12:00",
               "place" => "Hangar",
               "andress" => "Av. Dr. Freitas 8888",
               "url_img" => "url img",
               "user_id" => _
             } = json_response(conn, 200)
    end
  end
end

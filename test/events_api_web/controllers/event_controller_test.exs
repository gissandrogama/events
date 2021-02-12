defmodule EventsApiWeb.EnvetControllerTest do
  use EventsApiWeb.ConnCase, async: true
  import EventsApiWeb.Auth.Guardian
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

    test "returnar erro quando evento não existe", %{conn: conn} do
      user = user_fixture()
      params = Map.put(@valid_event, :user_id, user.id)
      Doings.create_event(params)
      id_ivalid = "b1c75040-670a-4043-9a1f-cdeedb227ed1"

      conn = get(conn, Routes.event_path(conn, :show, id_ivalid))

      assert %{"errors" => %{"detail" => "Not Found"}} = json_response(conn, 404)
    end
  end

  describe "create/2" do
    setup %{conn: conn} do
      user = user_fixture()
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

      conn =
        conn
        |> put_req_header("accept", "application/json")
        |> put_req_header("authorization", "bearer " <> token)

      {:ok, conn: conn}
    end

    test "retornar um evento quando parametros validos", %{conn: conn} do
      conn = post(conn, Routes.event_path(conn, :create), event: @valid_event)
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

  describe "create/2 sem atenticação" do
    test "retornar erro usuário não autenticado", %{conn: conn} do
      conn = post(conn, Routes.event_path(conn, :create), event: @valid_event)
      assert %{"error" => "Token não encontrado"} = json_response(conn, 401)
    end

    test "retornar erro se o token for invalido", %{conn: conn} do
      conn =
        conn
        |> put_req_header("accept", "application/json")
        |> put_req_header(
          "authorization",
          "bearer " <> "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJldmVudHNfYXBpIiwiZXhwI"
        )

      conn = post(conn, Routes.event_path(conn, :create), event: @valid_event)
      assert %{"error" => "Token expirado ou inválido"} = json_response(conn, 401)
    end
  end
end

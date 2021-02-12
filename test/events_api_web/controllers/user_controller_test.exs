defmodule EventsApiWeb.UserControllerTest do
  use EventsApiWeb.ConnCase, async: true
  import EventsApi.UserFixture

  setup %{conn: conn} do
    conn = conn

    %{conn: conn}
  end

  @valid_user %{name: "User padrão", email: "user_padrão@email.com", password: "123123"}

  describe "show" do
    test "returnar um usurário pelo id", %{conn: conn} do
      user = user_fixture(%{name: "Henry", email: "henry@email.com", password: "123123"})

      conn = get(conn, Routes.user_path(conn, :show, user.id))

      assert %{"nome" => "Henry", "email" => "henry@email.com", "id" => _} =
               json_response(conn, 200)
    end
  end

  describe "signin" do
    test "returnar um token quando email e senha válidos", %{conn: conn} do
      user_fixture(%{name: "Henry", email: "henry@email.com", password: "123123"})

      conn =
        post(
          conn,
          Routes.user_path(conn, :signin, %{"email" => "henry@email.com", "password" => "123123"})
        )

      assert %{"user" => _} = json_response(conn, 201)
    end

    test "returnar um error quando email não válidos", %{conn: conn} do
      user_fixture(%{name: "Henry", email: "henry@email.com", password: "123123"})

      conn =
        post(
          conn,
          Routes.user_path(conn, :signin, %{"email" => "henry@email", "password" => "123123"})
        )

      assert %{"message" => "unauthorizade"} = json_response(conn, 400)
    end

    test "returnar um error quando senha não válidos", %{conn: conn} do
      user_fixture(%{name: "Henry", email: "henry@email.com", password: "123123"})

      conn =
        post(
          conn,
          Routes.user_path(conn, :signin, %{"email" => "henry@email.com", "password" => "123"})
        )

      assert %{"message" => "unauthorizade"} = json_response(conn, 400)
    end
  end

  describe "create/2" do
    test "retornar um usuário quando parametros válidos", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @valid_user)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => _,
               "nome" => "User padrão",
               "email" => "user_padrão@email.com"
             } = json_response(conn, 200)
    end

    test "retornar erro quando o nome estive vazio", %{conn: conn} do
      conn =
        post(conn, Routes.user_path(conn, :create),
          user: %{name: "", email: "user_padrão@email.com", password: "123123"}
        )

      assert %{"errors" => %{"name" => ["É necessário preencher o nome"]}} =
               json_response(conn, 422)
    end

    test "retornar erro quando o email inválido", %{conn: conn} do
      conn =
        post(conn, Routes.user_path(conn, :create),
          user: %{name: "Henry", email: "user_padrão", password: "123123"}
        )

      assert %{"errors" => %{"email" => ["E-mail inválido!"]}} = json_response(conn, 422)
    end

    test "retornar erro quando o password menor que 6 caracteres", %{conn: conn} do
      conn =
        post(conn, Routes.user_path(conn, :create),
          user: %{name: "Henry", email: "user_padrão@email.com", password: "123"}
        )

      assert %{"errors" => %{"password" => ["password deve conter no mínimo 6 caracteres"]}} =
               json_response(conn, 422)
    end

    test "retornar erro quando os parametros vazios", %{conn: conn} do
      conn =
        post(conn, Routes.user_path(conn, :create), user: %{name: "", email: "", password: ""})

      assert %{"errors" => %{}} = json_response(conn, 422)
    end
  end
end

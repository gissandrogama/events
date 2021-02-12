defmodule EventsApi.AccountsTest do
  use EventsApi.DataCase, async: true
  alias EventsApi.Accounts

  @valid_params %{
    name: "Henry",
    email: "henry@email.com",
    password: "123456"
  }

  describe "accounts" do
    test "criar um usuário parâmetros validos" do
      {:ok, user} = Accounts.create_user(@valid_params)

      assert user.email == "henry@email.com"
    end

    test "retornar erro quando password for menor que 6 caracteres" do
      params = %{
        name: "Henry",
        email: "henry@email.com",
        password: "123"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(params)
      %{password: ["password deve conter no mínimo 6 caracteres"]} = errors_on(changeset)
    end

    test "retornar erro quando name não estiver vazio" do
      params = %{
        name: "",
        email: "henry@email.com",
        password: "123123"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(params)
      %{name: ["É necessário preencher o nome"]} = errors_on(changeset)
    end

    test "retornar erro quando email for invalido" do
      params = %{
        name: "Henry",
        email: "henry",
        password: "123456"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(params)
      %{email: ["E-mail inválido!"]} = errors_on(changeset)
    end

    test "retornando um usuário pelo id" do
      {:ok, user} = Accounts.create_user(@valid_params)
      {:ok, result} = Accounts.get_user!(user.id)

      assert result.name == "Henry"
    end
  end
end

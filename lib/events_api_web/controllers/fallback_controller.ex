defmodule EventsApiWeb.FallbackController do
  @moduledoc """
  Traduz os resultados da ação do controlador em respostas `Plug.Conn` válidas.

  Veja `Phoenix.Controller.action_fallback/1` para mais detalhes.
  """
  use EventsApiWeb, :controller

  # Esta cláusula trata os erros retornados pela inserção/atualização/exclusão do Ecto.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(EventsApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # Esta cláusula é um exemplo de como lidar com recursos que não podem ser encontrados.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(EventsApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: message})
  end
end

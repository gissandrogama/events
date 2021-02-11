defmodule EventsApiWeb.ChangesetView do
  use EventsApiWeb, :view

  @doc """
  Está função percorre e traduz os erros do changeset.

  Veja `Ecto.Changeset.traverse_errors/2` e
  `EventsApiWeb.ErrorHelpers.translate_error/1` para mais detalhes.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    # Quando codificado, o changeset retorna seus erros
    # como um objeto JSON. Então, nós apenas passamos adiante.
    %{errors: translate_errors(changeset)}
  end
end

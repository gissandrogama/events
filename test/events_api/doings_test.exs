defmodule EventsApi.DoingsTest do
  use EventsApi.DataCase, async: true
  alias EventsApi.Doings
  import EventsApi.UserFixture

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

  describe "Doings" do
    test "criar um evento parâmetros validos" do
      user = user_fixture()
      params = Map.put(@valid_event, :user_id, user.id)
      {:ok, event} = Doings.create_event(params)

      assert event.title == "Inteligência Emocional"
    end

    test "listar eventos" do
      user = user_fixture()
      params = Map.put(@valid_event, :user_id, user.id)
      Doings.create_event(params)
      event = Doings.list_events()

      assert event |> Enum.count() == 1
    end

    test "retornando um evento pelo id" do
      user = user_fixture()
      params = Map.put(@valid_event, :user_id, user.id)
      {:ok, event} = Doings.create_event(params)
      {:ok, result } = Doings.get_event!(event.id)

      assert result.title == "Inteligência Emocional"
    end
  end
end

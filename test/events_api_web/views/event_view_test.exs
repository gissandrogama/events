defmodule EventsApiWeb.EventViewTest do
  use ExUnit.Case, async: true

  alias EventsApiWeb.EventView

  test "render/2 returns index Event" do
    events = [
      %{
        id: "2af084fe-a625-44d1-b3f5-dda700050111",
        andress: "Av. Dr. Freitas 8888",
        date_finish: "25-10-2021",
        date_initial: "20-10-2021",
        description:
          "Todas as técnicas e ferramentas que vamos apresentar na palestra é 100% baseada na neurociência e nos estudos do comportamento humano.Se você não está satisfeito com a vida, então prepare-se para vivenciar o novo. Além dos aprendizados que você vai absorver, você também vai concorrer a sorteios de mentoria e livros. Então, participe! Não perca mais essa oportunidade na sua vida.",
        end_time: "12:00",
        place: "Hangar",
        start_time: "09:00",
        title: "Inteligência Emocional",
        url_img: "url img",
        user_id: "2af084fe-a625-44d1-b3f5-dda7000501a9"
      }
    ]

    assert [
             %{
               id: "2af084fe-a625-44d1-b3f5-dda700050111",
               andress: "Av. Dr. Freitas 8888",
               date_finish: "25-10-2021",
               date_initial: "20-10-2021",
               description:
                 "Todas as técnicas e ferramentas que vamos apresentar na palestra é 100% baseada na neurociência e nos estudos do comportamento humano.Se você não está satisfeito com a vida, então prepare-se para vivenciar o novo. Além dos aprendizados que você vai absorver, você também vai concorrer a sorteios de mentoria e livros. Então, participe! Não perca mais essa oportunidade na sua vida.",
               end_time: "12:00",
               place: "Hangar",
               start_time: "09:00",
               title: "Inteligência Emocional",
               url_img: "url img",
               user_id: "2af084fe-a625-44d1-b3f5-dda7000501a9"
             }
           ] = EventView.render("index.json", %{events: events})
  end

  test "render/2 returns show Event" do
    event = %{
      id: "2af084fe-a625-44d1-b3f5-dda700050110",
      andress: "Av. Dr. Freitas 8888",
      date_finish: "25-10-2021",
      date_initial: "20-10-2021",
      description:
        "Todas as técnicas e ferramentas que vamos apresentar na palestra é 100% baseada na neurociência e nos estudos do comportamento humano.Se você não está satisfeito com a vida, então prepare-se para vivenciar o novo. Além dos aprendizados que você vai absorver, você também vai concorrer a sorteios de mentoria e livros. Então, participe! Não perca mais essa oportunidade na sua vida.",
      end_time: "12:00",
      place: "Hangar",
      start_time: "09:00",
      title: "Inteligência Emocional",
      url_img: "url img",
      user_id: "2af084fe-a625-44d1-b3f5-dda7000501a9"
    }

    assert %{
             id: "2af084fe-a625-44d1-b3f5-dda700050110",
             andress: "Av. Dr. Freitas 8888",
             date_finish: "25-10-2021",
             date_initial: "20-10-2021",
             description:
               "Todas as técnicas e ferramentas que vamos apresentar na palestra é 100% baseada na neurociência e nos estudos do comportamento humano.Se você não está satisfeito com a vida, então prepare-se para vivenciar o novo. Além dos aprendizados que você vai absorver, você também vai concorrer a sorteios de mentoria e livros. Então, participe! Não perca mais essa oportunidade na sua vida.",
             end_time: "12:00",
             place: "Hangar",
             start_time: "09:00",
             title: "Inteligência Emocional",
             url_img: "url img",
             user_id: "2af084fe-a625-44d1-b3f5-dda7000501a9"
           } = EventView.render("show.json", %{event: event})
  end
end

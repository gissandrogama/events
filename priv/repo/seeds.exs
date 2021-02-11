# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EventsApi.Repo.insert!(%EventsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

%{
  title: "Congresso de Robotica",
  date_initial: "20-10-2021",
  date_finish: "25-10-2021",
  description: "evento para todas as idades, que tem o objetivo ...",
  start_time: "09:00",
  end_time: "12:00",
  place: "Amazon Hall",
  adress: "Almirante Barroso 7777",
  url_img: "url img",
  user_id: "8005bdbd-fcd1-4e6e-9d39-b48e1e868739"
}

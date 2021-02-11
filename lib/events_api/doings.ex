defmodule EventsApi.Doings do
  alias EventsApi.{Doings.Event, Repo}

  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end
end

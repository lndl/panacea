defmodule Prueba.EventView do
  use Prueba.Web, :view

  def render("index.json", %{events: events}) do
    %{data: render_many(events, Prueba.EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, Prueba.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      description: event.description,
      start_date: event.start_date,
      end_time: event.end_time}
  end
end

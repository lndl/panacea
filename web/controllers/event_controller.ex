defmodule Prueba.EventController do
  use Prueba.Web, :controller

  alias Prueba.Event

  def index(conn, _params) do
    events = Repo.all(Event)
    render(conn, "index.json-api", data: events)
  end

  def create(conn, %{"data" => data}) do
    event_attrs = JaSerializer.Params.to_attributes(data)
    changeset = Event.changeset(%Event{}, event_attrs)

    case Repo.insert(changeset) do
      {:ok, event} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", event_path(conn, :show, event))
        |> render("show.json-api", data: event)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Prueba.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    render(conn, "show.json-api", data: event)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    event = Repo.get!(Event, id)
    event_attrs = JaSerializer.Params.to_attributes(data)
    changeset = Event.changeset(event, event_attrs)

    case Repo.update(changeset) do
      {:ok, event} ->
        render(conn, "show.json-api", data: event_attrs)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Prueba.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(event)

    send_resp(conn, :no_content, "")
  end
end

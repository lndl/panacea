defmodule Prueba.Event do
  use Prueba.Web, :model

  schema "events" do
    field :name, :string
    field :description, :string
    field :start_date, Ecto.DateTime
    field :end_time, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :start_date, :end_time])
    |> validate_required([:name, :description, :start_date, :end_time])
    |> validate_proper_daterange(:start_date, :end_date)
  end

  defp validate_proper_daterange(changeset, start_date_field, end_date_field) do
    if get_field(changeset, start_date_field) <= get_field(changeset, end_date_field) do
      add_error(changeset, :nose, "start date cannot happen before end_date")
    else
      changeset
    end
  end
end

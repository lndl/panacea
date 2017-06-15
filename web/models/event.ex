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
    |> validate_proper_range(:start_date, :end_time)
  end

  defp validate_proper_range(changeset, lower_bound, upper_bound) do
    if get_field(changeset, lower_bound) >= get_field(changeset, upper_bound) do
      add_error(changeset, "#{lower_bound}-#{upper_bound}", "#{lower_bound} cannot happen before #{upper_bound}")
    else
      changeset
    end
  end
end

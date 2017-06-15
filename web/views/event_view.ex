defmodule Prueba.EventView do
  use Prueba.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :description, :start_date, :end_time]
end

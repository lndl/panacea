defmodule Prueba.PageController do
  use Prueba.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

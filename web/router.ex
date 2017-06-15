defmodule Prueba.Router do
  use Prueba.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

   scope "/", Prueba do
     pipe_through :api
     resources "/events", EventController, except: [:new, :edit]

     get "/", EventController, :index
   end
end

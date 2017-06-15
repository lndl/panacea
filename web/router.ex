defmodule Prueba.Router do
  use Prueba.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

   scope "/", Prueba do
     pipe_through :api
     resources "/events", EventController, except: [:new, :edit]

     get "/", EventController, :index
   end
end

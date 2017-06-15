defmodule Prueba.Router do
  use Prueba.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", Prueba do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

   scope "/api", Prueba do
     pipe_through :api
     resources "/events", EventController, except: [:new, :edit]
   end
end

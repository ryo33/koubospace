defmodule Koubo.Web.Router do
  use Koubo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Koubo.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/", PageController, :create_box
    get "/:name", PageController, :box
    post "/:name/ask", PageController, :ask
    post "/:name/give", PageController, :give
  end

  # Other scopes may use custom stacks.
  # scope "/api", Koubo.Web do
  #   pipe_through :api
  # end
end

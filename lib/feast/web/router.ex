defmodule Feast.Web.Router do
  use Feast.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :login_required do
    plug Feast.Web.Plug.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_layout do
    plug :put_layout, {Feast.Web.LayoutView, :admin}
  end

  pipeline :basic_layout do
    plug :put_layout, {Feast.Web.LayoutView, :basic}
  end

  pipeline :app_layout do
    plug :put_layout, {Feast.Web.LayoutView, :app}
  end

  pipeline :check_setup do
    plug Feast.Web.Plug.Setup
  end

  scope "/admin", Feast.Web do
    pipe_through [:browser, :login_required, :admin_layout]
  end

  scope "/auth", Feast.Web do
    pipe_through [:browser, :basic_layout]

    resources "/users", UserController, only: [:new, :create, :delete]

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", Feast.Web do
    pipe_through [:browser, :login_required, :app_layout, :check_setup]

    get "/", DashController, :index

    resources "/dash", DashController
    resources "/household", CollectiveController
    resources "/dinner", DinnerController
    resources "/plans", PlanController
    resources "/ingredients", IngredientController
  end
end

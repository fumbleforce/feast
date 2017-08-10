defmodule Feast.Web.NavController do
  use Feast.Web, :controller

  def index(conn, _params) do
    render conn, "nav.html"
  end
end

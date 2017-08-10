defmodule Feast.Web.DashController do
  use Feast.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
 end

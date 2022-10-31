defmodule SrcWeb.PageController do
  use SrcWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

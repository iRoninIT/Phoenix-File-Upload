defmodule FileUploaderWeb.PageController do
  use FileUploaderWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

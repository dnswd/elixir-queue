defmodule SrcWeb.ConsumerController do
  use SrcWeb, :controller

  alias Src.Queue
  alias Src.Queue.Consumer

  action_fallback SrcWeb.FallbackController

  def index(conn, _params) do
    consumers = Queue.list_consumers()
    render(conn, "index.json", consumers: consumers)
  end

  def create(conn, %{"consumer" => consumer_params}) do
    with {:ok, %Consumer{} = consumer} <- Queue.create_consumer(consumer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.consumer_path(conn, :show, consumer))
      |> render("show.json", consumer: consumer)
    end
  end

  def show(conn, %{"id" => id}) do
    consumer = Queue.get_consumer!(id)
    render(conn, "show.json", consumer: consumer)
  end

  def update(conn, %{"id" => id, "consumer" => consumer_params}) do
    consumer = Queue.get_consumer!(id)

    with {:ok, %Consumer{} = consumer} <- Queue.update_consumer(consumer, consumer_params) do
      render(conn, "show.json", consumer: consumer)
    end
  end

  def delete(conn, %{"id" => id}) do
    consumer = Queue.get_consumer!(id)

    with {:ok, %Consumer{}} <- Queue.delete_consumer(consumer) do
      send_resp(conn, :no_content, "")
    end
  end

  def index_by_topic(conn, %{"topic" => topic}) do
    consumers = Queue.filter_consumer_by_topic(topic)
    render(conn, "index.json", consumers: consumers)
  end
end

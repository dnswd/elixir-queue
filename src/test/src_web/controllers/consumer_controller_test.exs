defmodule SrcWeb.ConsumerControllerTest do
  use SrcWeb.ConnCase

  import Src.QueueFixtures

  alias Src.Queue.Consumer

  @create_attrs %{
    topic: "some topic",
    url_callback: "some url_callback"
  }
  @update_attrs %{
    topic: "some updated topic",
    url_callback: "some updated url_callback"
  }
  @invalid_attrs %{topic: nil, url_callback: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all consumers", %{conn: conn} do
      conn = get(conn, Routes.consumer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create consumer" do
    test "renders consumer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.consumer_path(conn, :create), consumer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.consumer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "topic" => "some topic",
               "url_callback" => "some url_callback"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.consumer_path(conn, :create), consumer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update consumer" do
    setup [:create_consumer]

    test "renders consumer when data is valid", %{conn: conn, consumer: %Consumer{id: id} = consumer} do
      conn = put(conn, Routes.consumer_path(conn, :update, consumer), consumer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.consumer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "topic" => "some updated topic",
               "url_callback" => "some updated url_callback"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, consumer: consumer} do
      conn = put(conn, Routes.consumer_path(conn, :update, consumer), consumer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete consumer" do
    setup [:create_consumer]

    test "deletes chosen consumer", %{conn: conn, consumer: consumer} do
      conn = delete(conn, Routes.consumer_path(conn, :delete, consumer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.consumer_path(conn, :show, consumer))
      end
    end
  end

  defp create_consumer(_) do
    consumer = consumer_fixture()
    %{consumer: consumer}
  end
end

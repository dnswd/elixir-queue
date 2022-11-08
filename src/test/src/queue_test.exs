defmodule Src.QueueTest do
  use Src.DataCase

  alias Src.Queue

  describe "consumers" do
    alias Src.Queue.Consumer

    import Src.QueueFixtures

    @invalid_attrs %{topic: nil, url_callback: nil}

    test "list_consumers/0 returns all consumers" do
      consumer = consumer_fixture()
      assert Queue.list_consumers() == [consumer]
    end

    test "get_consumer!/1 returns the consumer with given id" do
      consumer = consumer_fixture()
      assert Queue.get_consumer!(consumer.id) == consumer
    end

    test "create_consumer/1 with valid data creates a consumer" do
      valid_attrs = %{topic: "some topic", url_callback: "some url_callback"}

      assert {:ok, %Consumer{} = consumer} = Queue.create_consumer(valid_attrs)
      assert consumer.topic == "some topic"
      assert consumer.url_callback == "some url_callback"
    end

    test "create_consumer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Queue.create_consumer(@invalid_attrs)
    end

    test "update_consumer/2 with valid data updates the consumer" do
      consumer = consumer_fixture()
      update_attrs = %{topic: "some updated topic", url_callback: "some updated url_callback"}

      assert {:ok, %Consumer{} = consumer} = Queue.update_consumer(consumer, update_attrs)
      assert consumer.topic == "some updated topic"
      assert consumer.url_callback == "some updated url_callback"
    end

    test "update_consumer/2 with invalid data returns error changeset" do
      consumer = consumer_fixture()
      assert {:error, %Ecto.Changeset{}} = Queue.update_consumer(consumer, @invalid_attrs)
      assert consumer == Queue.get_consumer!(consumer.id)
    end

    test "delete_consumer/1 deletes the consumer" do
      consumer = consumer_fixture()
      assert {:ok, %Consumer{}} = Queue.delete_consumer(consumer)
      assert_raise Ecto.NoResultsError, fn -> Queue.get_consumer!(consumer.id) end
    end

    test "change_consumer/1 returns a consumer changeset" do
      consumer = consumer_fixture()
      assert %Ecto.Changeset{} = Queue.change_consumer(consumer)
    end
  end
end

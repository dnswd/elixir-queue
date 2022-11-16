defmodule Src.QueueFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Src.Queue` context.
  """

  @doc """
  Generate a consumer.
  """
  def consumer_fixture(attrs \\ %{}) do
    {:ok, consumer} =
      attrs
      |> Enum.into(%{
        topic: "some topic",
        url_callback: "some url_callback"
      })
      |> Src.Queue.create_consumer()

    consumer
  end
end

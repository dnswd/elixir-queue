defmodule SrcWeb.MessageQueueController do
  use SrcWeb, :controller

  alias Src.MessageQueue

  action_fallback SrcWeb.FallbackController

  # requires a message and topic in body
  def receive_message(conn, %{"message" => message, "topic" => topic}) do
    # check if genserver message queue with topic exists
    if Process.whereis(String.to_atom(topic)) == nil do
      # if not, start genserver message queue with topic
      MessageQueue.start_link(String.to_atom(topic))
    end
    Task.async(fn -> MessageQueue.add_message(message, String.to_existing_atom(topic)) end)
    messages = %{
      message: message,
      topic: topic
    }
    conn
    |> put_status(:created)
    |> render("show.json", message: messages)
  end


end

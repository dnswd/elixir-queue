defmodule Src.MessageQueue do
  use GenServer

  def start_link(topic) do
    GenServer.start_link(__MODULE__, [], name: topic)
  end

  def init(state) do
    {:ok, state}
  end

  def add_message(message, topic) do
    GenServer.call(topic, {:add_message, topic, message}, :infinity)
  end

  def handle_call({:add_message, topic, message}, _from, state) do
    # add message to queue
    state = [message | state]
    # insert to sender scheduler
    Enum.each(
      Src.Queue.filter_consumer_by_topic("#{topic}"),
      fn x -> GenServer.call(Src.PublishScheduler, {:store, %{url: x.url_callback, body: message, retries: 0}}) end
    )
    IO.puts("Message: #{message}")
    {:reply, :ok, state}
  end

end

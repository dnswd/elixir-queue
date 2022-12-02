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
    # do a job
    Enum.each(Src.Queue.filter_consumer_by_topic("#{topic}"), fn x -> Src.CallbackClient.send_callback(x.url_callback, message) end)
    IO.puts("Message: #{message}")
    {:reply, :ok, state}
  end
end

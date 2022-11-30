defmodule Src.MessageQueue do
  use GenServer

  def start_link(topic) do
    GenServer.start_link(__MODULE__, [], name: topic)
  end

  def init(state) do
    {:ok, state}
  end

  def add_message(message, topic) do
    GenServer.call(topic, {:add_message, message})
  end

  def handle_call({:add_message, message}, _from, state) do
    # add message to queue
    state = [message | state]
    # wait for previous job to finish
    Process.sleep(1000)
    # do a job
    IO.puts("Message: #{message}")
    {:reply, :ok, state}
  end
end

defmodule Src.PublishScheduler do
  use GenServer

  @send_interval_ms 500
  @retry_limit 5

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(queue) do
    Process.flag(:trap_exit, true)
    timer = Process.send_after(self(), :check, @send_interval_ms)

    {:ok, %{queue: queue, timer: timer}}
  end

  @impl true
  def handle_call({:store, message}, _from, %{queue: queue, timer: timer} = _state) do
    new_queue = [message | queue]
    {:reply, :ok, %{_state | queue: new_queue}}
  end

  @impl true
  def handle_info(:check, %{queue: queue, timer: timer} = state) do
    new_timer = Process.send_after(self(), :check, @send_interval_ms)
    count = Enum.count(queue)
    if count > 0 do
      msg = Enum.fetch!(queue, count - 1)
      new_queue = Enum.drop(queue, -1)
      spawn fn -> send_message(msg) end
      {:noreply, %{queue: new_queue, timer: new_timer}}
    else
      {:noreply, %{state | timer: new_timer}}
    end
  end

  defp send_message(%{url: url, body: body, retries: retries} = message) do
    res = Src.CallbackClient.send_callback(url, body)
    case res do
      {:success} -> {:success}
      {:do_not_retry} -> {:do_not_retry}
      {:do_retry} ->
        if retries > @retry_limit do
          IO.puts("Retry limit reached")
          {:do_not_retry}
        else
          GenServer.call(Src.PublishScheduler, {:store, %{url: url, body: body, retries: retries + 1}})
          {:do_retry}
        end
    end
  end

end

defmodule Publisher do

  @impl true
  def publish_message(body) do
    send_message(body)
    {:ok}
  end

  defp send_message(body) do
    Enum.each(Src.Queue.list_consumers, fn x -> Src.CallbackClient.send_callback(x.url_callback, body) end)
  end

end
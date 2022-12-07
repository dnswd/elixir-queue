defmodule Src.CallbackClient do
  use HTTPoison.Base

  def send_callback(url, body) do
    headers = [{"Content-type", "application/json"}]
    response =  post(url, Poison.encode!(body), headers, [])

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts(body)
        {:success}

      {:ok, %HTTPoison.Response{}} ->
        IO.puts("Request Failed")
        {:do_not_retry}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        IO.puts("to be scheduled to retry")
        {:do_retry}
    end
  end
end

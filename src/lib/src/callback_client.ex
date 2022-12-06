defmodule Src.CallbackClient do
  use HTTPoison.Base

  def send_callback(url, body) do
    headers = [{"Content-type", "application/json"}]
    case post(url, Poison.encode!(%{message: body}), headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end

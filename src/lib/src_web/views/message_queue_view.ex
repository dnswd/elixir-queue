defmodule SrcWeb.MessageQueueView do
  use SrcWeb, :view
  alias SrcWeb.MessageQueueView

  def render("show.json", %{message: messages}) do
    %{data: render_one(messages, MessageQueueView, "message.json")}
  end

  def render("message.json", %{message_queue: messages}) do
    %{
      message: messages.message,
      topic: messages.topic
    }
  end
end

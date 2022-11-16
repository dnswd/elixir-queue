defmodule SrcWeb.ConsumerView do
  use SrcWeb, :view
  alias SrcWeb.ConsumerView

  def render("index.json", %{consumers: consumers}) do
    %{data: render_many(consumers, ConsumerView, "consumer.json")}
  end

  def render("show.json", %{consumer: consumer}) do
    %{data: render_one(consumer, ConsumerView, "consumer.json")}
  end

  def render("consumer.json", %{consumer: consumer}) do
    %{
      id: consumer.id,
      topic: consumer.topic,
      url_callback: consumer.url_callback
    }
  end
end

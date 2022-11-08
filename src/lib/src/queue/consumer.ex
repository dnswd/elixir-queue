defmodule Src.Queue.Consumer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consumers" do
    field :topic, :string
    field :url_callback, :string

    timestamps()
  end

  @doc false
  def changeset(consumer, attrs) do
    consumer
    |> cast(attrs, [:topic, :url_callback])
    |> validate_required([:topic, :url_callback])
  end
end

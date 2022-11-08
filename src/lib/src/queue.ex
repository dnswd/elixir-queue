defmodule Src.Queue do
  @moduledoc """
  The Queue context.
  """

  import Ecto.Query, warn: false
  alias Src.Repo

  alias Src.Queue.Consumer

  @doc """
  Returns the list of consumers.

  ## Examples

      iex> list_consumers()
      [%Consumer{}, ...]

  """
  def list_consumers do
    Repo.all(Consumer)
  end

  @doc """
  Gets a single consumer.

  Raises `Ecto.NoResultsError` if the Consumer does not exist.

  ## Examples

      iex> get_consumer!(123)
      %Consumer{}

      iex> get_consumer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_consumer!(id), do: Repo.get!(Consumer, id)

  @doc """
  Creates a consumer.

  ## Examples

      iex> create_consumer(%{field: value})
      {:ok, %Consumer{}}

      iex> create_consumer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_consumer(attrs \\ %{}) do
    %Consumer{}
    |> Consumer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a consumer.

  ## Examples

      iex> update_consumer(consumer, %{field: new_value})
      {:ok, %Consumer{}}

      iex> update_consumer(consumer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_consumer(%Consumer{} = consumer, attrs) do
    consumer
    |> Consumer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a consumer.

  ## Examples

      iex> delete_consumer(consumer)
      {:ok, %Consumer{}}

      iex> delete_consumer(consumer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_consumer(%Consumer{} = consumer) do
    Repo.delete(consumer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking consumer changes.

  ## Examples

      iex> change_consumer(consumer)
      %Ecto.Changeset{data: %Consumer{}}

  """
  def change_consumer(%Consumer{} = consumer, attrs \\ %{}) do
    Consumer.changeset(consumer, attrs)
  end
end

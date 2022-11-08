defmodule Src.Repo.Migrations.CreateConsumers do
  use Ecto.Migration

  def change do
    create table(:consumers) do
      add :topic, :string
      add :url_callback, :string

      timestamps()
    end
  end
end

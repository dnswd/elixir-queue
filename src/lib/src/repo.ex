defmodule Src.Repo do
  use Ecto.Repo,
    otp_app: :src,
    adapter: Ecto.Adapters.Postgres
end

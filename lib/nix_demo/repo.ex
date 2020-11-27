defmodule NixDemo.Repo do
  use Ecto.Repo,
    otp_app: :nix_demo,
    adapter: Ecto.Adapters.Postgres
end

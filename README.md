# NixDemo

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## NixSetup

- create the db directory `mkdir db`
- initialize it `initdb`
- create the db `createdb nix_demo_dev`

## testing build tools

- test mix-to-nix with `nix-build ./build_mix_2_nix.nix`
- test build_mix with `nix-build ./build_mix.nix`
- test nix-elixir with `nix-build ./build_with_nix_elixir.nix`


let
  nixpkgs = import <nixpkgs-unstable> { };
  packages = nixpkgs.beam.packagesWith nixpkgs.beam.interpreters.erlangR23;

in packages.buildMix {
  name = "nix_demo";
  src = ./.;
  DATABASE_URL = "postgresql://postgres:postgres@localhost:5432/db";
  SECRET_KEY_BASE =
    "TcAMYD4pYrH1W7YsF5/8VgoYxuogO8ii4KPKpVFxNcT2E2b4tkqDt7rzvdzbJ+/h";
  elixir = nixpkgs.beam.packages.erlangR23.elixir_1_11;
  version = "0.0.1";
}

let
  mixOverlay =
    builtins.fetchGit { url = "https://github.com/hauleth/nix-elixir.git"; };
  nixpkgs = import <nixpkgs-unstable> { overlays = [ (import mixOverlay) ]; };
  packages = nixpkgs.beam.packagesWith nixpkgs.beam.interpreters.erlangR23;

in packages.buildMix' {
  name = "union";
  src = builtins.fetchGit {
    url = "ssh://git@github.com/happysalada/nix_demo";
    rev = "5c1253231b7d37a45e14671ff37888173980e082";
  };
  elixir = nixpkgs.beam.packages.erlangR23.elixir_1_11;
  version = "0.0.1";
}

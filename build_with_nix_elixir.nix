let
  mixOverlay =
    builtins.fetchGit { url = "https://github.com/hauleth/nix-elixir.git"; };
  nixpkgs = import <nixpkgs-unstable> { overlays = [ (import mixOverlay) ]; };
  packages = nixpkgs.beam.packagesWith nixpkgs.beam.interpreters.erlangR23;

in packages.buildMix' {
  name = "nix_demo";
  src = ./.;
  elixir = nixpkgs.beam.packages.erlangR23.elixir_1_11;
  version = "0.0.1";
}

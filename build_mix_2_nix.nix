with import <nixpkgs> { };

let
  inherit (callPackage (fetchGit {
    url = "https://gitlab.com/transumption/mix-to-nix";
    rev = "b70cb8f7fca80d0c5f7539dbfec497535e07d75c";
  }) { })
    mixToNix;

in mixToNix { src = ./.; }

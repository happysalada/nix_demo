with import ../nixpkgs { };

let
  packages = beam.packagesWith beam.interpreters.erlang;
  src = builtins.fetchGit {
    url = "ssh://git@github.com/happysalada/nix_demo";
    rev = "23812c570f43417c2e78f8b91b98947c4fbdcde8";
  };

  nodeDependencies =
    (pkgs.callPackage ./assets/default.nix { }).shell.nodeDependencies;

in packages.buildMix {
  name = "nix_demo";
  mixEnv = "prod";
  version = "0.0.1";
  depsSha256 = "sha256-YR2N3KzFLj/pHodacEj7CLq1auMAi+m3ONvff9wXOqQ=";
  inherit src;
  buildEnvVars = {
    DATABASE_URL="";
    SECRET_KEY_BASE="";
  };
  nativeBuildInputs = [ darwin.apple_sdk.frameworks.CoreServices ];
  preConfigure = ''
    cd ./assets

    ln -s ${nodeDependencies}/lib/node_modules ./node_modules
    export PATH="${nodeDependencies}/bin:$PATH"

    webpack --config ./webpack.config.js
    cd ..
  '';
}

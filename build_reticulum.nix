with import ../nixpkgs { };
let
  packages = beam.packagesWith beam.interpreters.erlang;
  src = builtins.fetchGit {
    url = "ssh://git@github.com/mozilla/reticulum";
    rev = "5f216106aef34a1953a5e9b90f09ee096f4d5e01";
  };

  name = "reticulum";
  version = "0.0.1";
  mixEnv = "prod";

  mixDeps = packages.fetchMixDeps {
    inherit src name mixEnv version;
    sha256 = "sha256-EmVS+vry0cg1N/ODLtJ27t/OnJr2Ock3B9PapGempLA=";
    DATABASE_URL = "";
    SECRET_KEY_BASE = "";
  };


in
packages.buildMix {
  inherit src name version mixEnv mixDeps;
  DATABASE_URL = "";
  SECRET_KEY_BASE = "";
  defaultEnvVars = false;
  nativeBuildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.CoreServices ];
}

with import ../nixpkgs { };
let
  packages = beam.packagesWith beam.interpreters.erlang;
  src = builtins.fetchGit {
    url = "ssh://git@github.com/mozilla/reticulum";
    rev = "5f216106aef34a1953a5e9b90f09ee096f4d5e01";
  };

  pname = "reticulum";
  version = "0.0.1";
  mixEnv = "prod";

  mixDeps = packages.fetchMixDeps {
    pname = "mix-deps-${pname}";
    inherit src mixEnv version;
    sha256 = "sha256-cfs1i5nCCnyhi82SFBO3m65pu4pxh6O9qd9VwoelnQI=";
  };

in
packages.buildMix {
  inherit src pname version mixEnv mixDeps;
  defaultEnvVars = false;
  nativeBuildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.CoreServices ];
}

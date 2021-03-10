with import ../nixpkgs { };
let
  packages = beam.packagesWith beam.interpreters.erlang;
  src = builtins.fetchGit {
    url = "ssh://git@github.com/happysalada/nix_demo";
    rev = "23812c570f43417c2e78f8b91b98947c4fbdcde8";
  };

  pname = "nix_demo";
  version = "0.0.1";
  mixEnv = "prod";

  mixDeps = packages.fetchMixDeps {
    pname = "mix-deps-${pname}";
    inherit src mixEnv version;
    DATABASE_URL = "";
    SECRET_KEY_BASE = "";
    sha256 = "sha256-YR2N3KzFLj/pHodacEj7CLq1auMAi+m3ONvff9wXOqQ=";
  };

  nodeDependencies =
    (pkgs.callPackage ./assets/default.nix { }).shell.nodeDependencies;

  frontEndFiles = stdenvNoCC.mkDerivation {
    pname = "frontend-${pname}";

    nativeBuildInputs = [ nodejs ];

    inherit src version;

    buildPhase = ''
      cp -r ./assets $TEMPDIR

      mkdir -p $TEMPDIR/assets/node_modules/.cache
      cp -r ${nodeDependencies}/lib/node_modules $TEMPDIR/assets
      export PATH="${nodeDependencies}/bin:$PATH"

      cd $TEMPDIR/assets
      webpack --config ./webpack.config.js
      cd ..
    '';

    installPhase = ''
      cp -r ./priv/static $out/
    '';

    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = "sha256-WsPOpP3EVp/VF9LrW0NtTYVMpWhlcSBU5Z7xfrevnII=";

    impureEnvVars = lib.fetchers.proxyImpureEnvVars;
  };

in
packages.buildMix {
  inherit src pname version mixEnv mixDeps;
  DATABASE_URL = "";
  SECRET_KEY_BASE = "";
  nativeBuildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.CoreServices ];
  preInstall = ''
    mkdir -p ./priv/static
    cp -r ${frontEndFiles} ./priv/static
  '';
}

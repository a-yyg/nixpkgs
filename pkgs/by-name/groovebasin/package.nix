{ lib, buildNpmPackage, importNpmLock, fetchFromGitHub, libgroove, version ? "1.5.1" }:
let
  pkgs' = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/a5c9c6373aa35597cd5a17bc5c013ed0ca462cf0.tar.gz";
      sha256 = "sha256:0wpl8rhkfd7s4nm32vfn6fha0g4a1p5214117vvwsl4y3l1gm68a";
    })
    {
      system = "x86_64-linux";
    };

  nodejs-10_x = pkgs'.nodejs-10_x;
  python2 = pkgs'.python2;
in
buildNpmPackage {
  pname = "groovebasin";
  inherit version;

  src = fetchFromGitHub {
    owner = "andrewrk";
    repo = "groovebasin";
    rev = "${version}";
    sha256 = "sha256-DXrUWle7EYcKv7b4bC08pmFk7oq3EAdBAev+tyEG+7w=";
  };

  nodejs = nodejs-10_x;

  # npmDeps = importNpmLock {
  #   npmRoot = ./.;
  # };

  # npmConfigHook = importNpmLock.npmConfigHook;

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-iHSDDlkeBQBtKUwP6ytvaY/SbwgrN7ST8Hdf5h1ZYRg=";
  # npmFlags = [ "--legacy-peer-deps" "--ignore-scripts" ];

  # nativeBuildInputs = [ nodejs-8_x python2 ];
  buildInputs = [ libgroove ];
}

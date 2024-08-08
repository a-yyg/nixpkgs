{ lib
, stdenv
, fetchzip
, gnumake
}:
let
  cheat-engine-src = fetchzip {
    url = "https://github.com/cheat-engine/cheat-engine/archive/refs/heads/master.zip";
    sha256 = lib.fakeSha256;
  };
in
stdenv.mkDerivation {
  pname = "cesever";
  version = "7.5";
  src = "${cheat-engine-src}/Cheat Engine/ceserver";
  nativeBuildInputs = [ gnumake ];

  buildPhase = ''
    cd gcc
    make
  '';

  installPhase = ''
    ls -la
  '';
}

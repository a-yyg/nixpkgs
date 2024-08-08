{ lib
, stdenv
, fetchzip
, gnumake
, zlib
}:
stdenv.mkDerivation {
  pname = "cesever";
  version = "7.5";
  src = fetchzip {
    url = "https://github.com/cheat-engine/cheat-engine/archive/refs/heads/master.zip";
    sha256 = "sha256-zurEnu4YDGZDyvWSejzqZ/vlMpLUigp2Yj6t2qp3RZg=";
  };
  nativeBuildInputs = [ gnumake ];

  buildInputs = [ zlib ];

  buildPhase = ''
    cd "Cheat Engine/ceserver/gcc"
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv ceserver $out/bin
  '';

  meta = with lib; {
    description = "Cheat Engine Server";
    homepage = "https://www.cheatengine.org/";
    mainProgram = "ceserver";
  };
}

{ lib
, stdenv
, symlinkJoin
, pkgconfig
, binutils
}:

{ name
, srcs ? []
, cflags ? []
, deps ? []
, static ? false
}:

stdenv.mkDerivation {
  inherit name;
  nativeBuildInputs = [ stdenv.cc ];
  buildInputs = [ binutils ] ++ deps;

  src = symlinkJoin {
    name = "src";
    paths = srcs;
  };

  buildPhase = 
  let
    joinStrings = strings: lib.strings.concatStringsSep " " strings;
    flags = "$(pkg-config --cflags --libs " + joinStrings deps + ")";
  in
  ''
    mkdir -p $out/bin
  '' + (if static then ''
    ${stdenv.cc} -c ${cflags} ${joinStrings srcs} ${flags} -o ${name}.o
    ar rcs lib${name}.a ${name}.o
  '' else ''
    ${stdenv.cc} -c -fPIC ${cflags} ${joinStrings srcs} ${flags} -o ${name.o}
    ${stdenv.cc} -shared -o lib${name}.so ${name.o}
  '');

  installPhase = ''
    mkdir -p $out/bin
    cp lib${name}.* $out/lib
  '';
}

{ stdenv
, lib
, fetchFromGitHub
, cmake
  # , ffmpeg_4
, chromaprint
, libebur128
, SDL2
, version ? "4.3.0"
}:
let
  ffmpeg_3 = (import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/d1c3fea7ecbed758168787fe4e4a3157e52bc808.tar.gz";
      sha256 = "sha256:0ykm15a690v8lcqf2j899za3j6hak1rm3xixdxsx33nz7n3swsyy";
    })
    {
      system = "x86_64-linux";
      config.permittedInsecurePackages = [
        "ffmpeg-3.4.8"
      ];
    }).ffmpeg_3;
in
stdenv.mkDerivation {
  pname = "libgroove";
  inherit version;

  src = fetchFromGitHub {
    owner = "andrewrk";
    repo = "libgroove";
    rev = "${version}";
    sha256 = "sha256-7cb+HLVBA0ykmKQ2rFJk2YKNPzQd7r7IYRWUF2dqSdE=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ ffmpeg_3 chromaprint libebur128 SDL2 ];

  NIX_CFLAGS_COMPILE = "-Wno-error";

  meta = with lib; {
    description = "streaming audio processing library";
    homepage = "https://github.com/andrewrk/libgroove";
    license = licenses.mit;
    platforms = platforms.x86_64;
  };
}

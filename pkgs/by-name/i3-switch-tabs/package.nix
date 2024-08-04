{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "i3-switch-tabs";
  version = "0.1.4";
  src = fetchFromGitHub {
    owner = "nikola-kocic";
    repo = "i3-switch-tabs";
    rev = "v${version}";
    sha256 = "sha256-9XCl5V1JgmAAVafQ3uR9x+GbuFL8mTC4Gt/bOL6Igic=";
  };

  cargoHash = "sha256-v8XyTTvc6SMyQ/199sCQGKzMKBR0d4qRVFDJ32QB/Uw=";

  meta = {
    description = "Switch top-level tabs in i3-wm";
    homepage = "https://github.com/nikola-kocic/i3-switch-tabs";
    license = lib.licenses.mit;
    maintainers = [];
    mainProgram = "i3-switch-tabs";
  };
}

{ lib, fetchFromGitHub, rustPlatform, pkg-config, openssl }:
rustPlatform.buildRustPackage rec {
  pname = "tracker";
  version = "0.1.8";
  src = fetchFromGitHub {
    owner = "ShenMian";
    repo = "tracker";
    rev = "v${version}";
    sha256 = "sha256-MP4kLb1he98GcE/HQPXYY4pDqe44QEqWQ8K/YzMQ4fk=";
  };

  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = [
    openssl
  ];
  cargoLock = {
    lockFile = ./Cargo.lock;
    # outputHashes = {
    #   "sgp4-2.2.0" = "sha256-oH+uPRHGhE3dslIkzD2stIw2bUJFrttFUNq/txGtppE=";
    # };
  };

  meta = {
    description = " A terminal-based real-time satellite tracking and orbit prediction application. ";
    homepage = "https://github.com/ShenMian/tracker";
    license = lib.licenses.asl20;
    maintainers = [];
    mainProgram = "tracker";
  };
}

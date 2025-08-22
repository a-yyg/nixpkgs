{
  lib,
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "latest";

  src = fetchzip {
    url = "https://github.com/PancakeTAS/lsfg-vk/releases/download/v1.0.0/lsfg-vk_noui.zip";
    hash = "sha256-xGilXPRFxb+Tfko4XwCR2E3BAPTMvZmGrfCqqAoQHJA=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/lib $out/share/vulkan/implicit_layer.d
    cp $src/lib/liblsfg-vk.so $out/lib/
    cp $src/share/vulkan/implicit_layer.d/VkLayer_LS_frame_generation.json $out/share/vulkan/implicit_layer.d/
  '';

  meta = with lib; {
    description = "A Vulkan layer for frame generation";
    homepage = "https://github.com/pancake-org/lsfg-vk";
    license = licenses.mit;
    platforms = platforms.linux;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}

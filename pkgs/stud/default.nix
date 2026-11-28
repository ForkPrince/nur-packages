{
  autoPatchelfHook,
  glib-networking,
  vulkan-loader,
  libxkbcommon,
  callPackage,
  makeWrapper,
  fontconfig,
  stdenvNoCC,
  libsecret,
  fetchurl,
  libglvnd,
  openssl,
  ffmpeg,
  curl,
  dpkg,
  sdl3,
  zlib,
  udev,
  qt6,
  lib,
}: let
  ver = lib.helper.read ./version.json;

  wpewebkit = callPackage ./wpewebkit.nix {};
in
  stdenvNoCC.mkDerivation rec {
    pname = "stud";
    inherit (ver) version;

    src = fetchurl (lib.helper.getSingle ver);

    nativeBuildInputs = [
      autoPatchelfHook
      makeWrapper
      dpkg
    ];

    buildInputs = [
      vulkan-loader
      libxkbcommon
      fontconfig
      qt6.qtbase
      libsecret
      wpewebkit
      libglvnd
      openssl
      ffmpeg
      curl
      sdl3
      zlib
      udev
    ];

    sourceRoot = ".";

    dontWrapQtApps = true;

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb -x $src .
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -r usr/* $out/

      runHook postInstall
    '';

    postFixup = ''
      for bin in "$out"/bin/stud "$out"/libexec/stud/*; do
        [ -f "$bin" ] && [ -x "$bin" ] || continue
        wrapProgram "$bin" \
          --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
          --prefix GIO_EXTRA_MODULES : "${glib-networking}/lib/gio/modules"
      done
    '';

    meta = {
      description = "An Unofficial Open-Source Roblox Launcher for Linux";
      homepage = "https://github.com/CatPieLeaf/Stud";
      license = lib.licenses.agpl3Only;
      maintainers = with lib.maintainers; [Prinky];
      platforms = ["x86_64-linux"];
      mainProgram = "stud";
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }

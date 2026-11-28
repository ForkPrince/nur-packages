{
  autoPatchelfHook,
  ffmpeg-headless,
  vulkan-loader,
  alsa-plugins,
  libxkbcommon,
  wl-clipboard,
  makeWrapper,
  symlinkJoin,
  stdenvNoCC,
  fontconfig,
  xdg-utils,
  fetchurl,
  pipewire,
  alsa-lib,
  openssl,
  wayland,
  stdenv,
  libX11,
  libxcb,
  libva,
  wtype,
  libxi,
  curl,
  dpkg,
  _7zz,
  lib,
}: let
  ver = lib.helper.read ./version.json;

  pname = "hex";
  inherit (ver) version;

  src = fetchurl (lib.helper.getPlatform stdenvNoCC.hostPlatform.system ver);

  meta = {
    description = "Local voice dictation that transcribes on your device and pastes at the cursor";
    homepage = "https://anoma.ly/hex/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [Prinky];
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    mainProgram = "hex";
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
in
  if stdenvNoCC.hostPlatform.isDarwin
  then
    stdenvNoCC.mkDerivation (lib.helper.mkDarwin {
      inherit pname version src meta;
      nativeBuildInputs = [_7zz];
    })
  else let
    alsaPlugins = symlinkJoin {
      name = "hex-alsa-plugins";
      paths = [
        "${pipewire}/lib/alsa-lib"
        "${alsa-plugins}/lib/alsa-lib"
      ];
    };

    runtimePackages = [
      ffmpeg-headless
      wl-clipboard
      xdg-utils
      wtype
      curl
    ];
  in
    stdenvNoCC.mkDerivation rec {
      inherit pname version src meta;

      nativeBuildInputs = [
        autoPatchelfHook
        makeWrapper
        dpkg
      ];

      buildInputs = [
        stdenv.cc.cc.lib
        vulkan-loader
        libxkbcommon
        fontconfig
        alsa-lib
        pipewire
        openssl
        wayland
        libX11
        libxcb
        libva
        libxi
      ];

      sourceRoot = ".";

      unpackPhase = ''
        runHook preUnpack
        dpkg-deb -x $src .
        runHook postUnpack
      '';

      installPhase = ''
        runHook preInstall

        install -Dm755 usr/bin/hex $out/bin/hex
        install -Dm644 usr/share/applications/anomaly.hex.desktop $out/share/applications/anomaly.hex.desktop
        substituteInPlace $out/share/applications/anomaly.hex.desktop \
          --replace-fail /usr/bin/hex "$out/bin/hex"
        cp -r usr/share/icons $out/share/icons
        cp -r usr/share/licenses $out/share/licenses

        runHook postInstall
      '';

      postFixup = ''
        wrapProgram $out/bin/hex \
          --prefix PATH : ${lib.makeBinPath runtimePackages} \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs} \
          --set ALSA_PLUGIN_DIR ${alsaPlugins}
      '';
    }

{
  makeWrapper,
  stdenvNoCC,
  fetchurl,
  lib,
}: let
  ver = lib.helper.read ./version.json;

  pname = "wiicompiled-setup";
  src = fetchurl (lib.helper.getPlatform stdenvNoCC.hostPlatform.system ver);
  inherit (ver) version;

  meta = {
    description = "Tool that statically recompiles your own Mario Kart Wii disc into a native PC port";
    homepage = "https://github.com/patchzyy/Wiicompiled";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    maintainers = with lib.maintainers; [Prinky];
    mainProgram = pname;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
in
  if stdenvNoCC.hostPlatform.isDarwin
  then
    stdenvNoCC.mkDerivation {
      inherit pname version src meta;

      sourceRoot = "source";

      nativeBuildInputs = [makeWrapper];

      dontConfigure = true;
      dontBuild = true;
      dontFixup = true;

      unpackPhase = ''
        runHook preUnpack
        mkdir -p source
        payload_line=$(awk '/^__WIICOMPILED_PAYLOAD__$/ { print NR + 1; exit }' "$src")
        tail -n +"$payload_line" "$src" | tar -xzf - -C source
        runHook postUnpack
      '';

      installPhase = ''
        runHook preInstall

        install -d "$out/share/${pname}"
        cp -R . "$out/share/${pname}/"

        install -d "$out/bin"
        makeWrapper "$out/share/${pname}/wiicompiled-setup" "$out/bin/${pname}" \
          --suffix PATH : "/usr/bin:/bin:/usr/sbin:/sbin"

        runHook postInstall
      '';
    }
  else
    lib.helper.mkAppImage {
      inherit pname version src meta;

      desktopName = "WiiCompiled Setup";
      desktopComment = "Translate, compile, and launch Mario Kart Wii natively on Linux";
      desktopId = "wiicompiled-setup";
      categories = ["Game"];
      icon = "wiicompiled-setup";
      terminal = true;
    }

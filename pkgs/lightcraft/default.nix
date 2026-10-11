{
  makeDesktopItem,
  appimageTools,
  stdenvNoCC,
  fetchurl,
  _7zz,
  lib,
}: let
  ver = lib.helper.read ./version.json;

  pname = "lightcraft";
  inherit (ver) version;
  src = fetchurl (lib.helper.getPlatform stdenvNoCC.hostPlatform.system ver);

  meta = {
    description = "Photo editor with color grading and RAW developing";
    homepage = "https://getartcraft.com/apps/lightcraft";
    maintainers = with lib.maintainers; [Prinky];
    license = with lib.licenses; [asl20 mit];
    platforms = lib.platforms.darwin ++ lib.platforms.linux;
    mainProgram = "lightcraft";
  };
in
  if stdenvNoCC.hostPlatform.isDarwin
  then
    stdenvNoCC.mkDerivation (lib.helper.mkDarwin {
      inherit pname version src meta;

      nativeBuildInputs = [_7zz];
    })
  else let
    contents = appimageTools.extract {inherit pname version src;};

    desktopItem = makeDesktopItem {
      name = "lightcraft";
      desktopName = "LightCraft";
      comment = meta.description;
      exec = "lightcraft %U";
      icon = "lightcraft";
      terminal = false;
      categories = ["Graphics"];
    };
  in
    appimageTools.wrapType2 {
      inherit pname version src meta;

      extraInstallCommands = ''
        install -Dm444 ${desktopItem}/share/applications/*.desktop $out/share/applications/lightcraft.desktop
        if [ -d ${contents}/usr/share/icons ]; then
          cp -r ${contents}/usr/share/icons $out/share/ || true
        fi
        icon=$(find ${contents} -maxdepth 2 -name "*.png" | head -n1)
        if [ -n "$icon" ]; then
          install -Dm444 "$icon" $out/share/icons/hicolor/512x512/apps/lightcraft.png || true
        fi
      '';
    }

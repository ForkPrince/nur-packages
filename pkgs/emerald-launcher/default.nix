{
  emerald-legacy-launcher,
  stdenvNoCC,
  fetchurl,
  _7zz,
  lib,
}:
if stdenvNoCC.hostPlatform.isDarwin
then let
  ver = lib.helper.read ./version.json;
in
  stdenvNoCC.mkDerivation (lib.helper.mkDarwin {
    pname = "emerald-launcher";

    src = fetchurl (lib.helper.getSingle ver);
    inherit (ver) version;

    nativeBuildInputs = [_7zz];

    meta = {
      description = "A FOSS, cross-platform launcher for Minecraft Legacy Edition";
      homepage = "https://github.com/LCE-Hub/LCE-Emerald-Launcher";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [Prinky];
      platforms = lib.platforms.darwin;
      mainProgram = "emerald-legacy-launcher";
    };
  })
else emerald-legacy-launcher

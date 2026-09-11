{
  gimp-with-plugins,
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
    pname = "gimp";
    inherit (ver) version;

    src = fetchurl (lib.helper.getPlatform stdenvNoCC.hostPlatform.system ver);

    nativeBuildInputs = [_7zz];

    unpackPhase = ''
      runHook preUnpack
      7zz x "$src" -snld
      runHook postUnpack
    '';

    meta = {
      description = "GNU Image Manipulation Program";
      homepage = "https://www.gimp.org/";
      maintainers = with lib.maintainers; [Prinky];
      license = lib.licenses.gpl3Plus;
    };
  })
else gimp-with-plugins

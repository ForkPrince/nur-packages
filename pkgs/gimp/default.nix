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
      7zz x "$src" -snld || true
      runHook postUnpack
    '';

    postFixup = ''
      app="$out/Applications/GIMP.app"
      rm -rf "$app/Contents/Resources/share"
      ln -sf ../locale "$app/Contents/Resources/share"
      rm -rf "$app/Contents/lib/Python.framework/Versions/3.14/Resources/Python.app/Contents/share"
      ln -sf ../../../../../../../share "$app/Contents/lib/Python.framework/Versions/3.14/Resources/Python.app/Contents/share"
    '';

    meta = {
      description = "GNU Image Manipulation Program";
      homepage = "https://www.gimp.org/";
      maintainers = with lib.maintainers; [Prinky];
      license = lib.licenses.gpl3Plus;
    };
  })
else gimp-with-plugins

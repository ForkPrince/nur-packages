{
  helixnotes,
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
    pname = "helixnotes";

    src = fetchurl (lib.helper.getSingle ver);
    inherit (ver) version;

    nativeBuildInputs = [_7zz];

    meta = {
      description = "A local, open-source Markdown note-taking app.";
      homepage = "https://helixnotes.com";
      maintainers = with lib.maintainers; [Prinky];
      license = lib.licenses.agpl3Plus;
      platforms = lib.platforms.darwin;
      mainProgram = "helixnotes";
    };
  })
else helixnotes
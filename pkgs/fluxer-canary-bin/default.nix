# Modified from https://github.com/NixOS/nixpkgs/pull/490554
{
  fluxer-canary-bin,
  stdenvNoCC,
  fetchurl,
  unzip,
  lib,
}:
if stdenvNoCC.hostPlatform.isDarwin
then let
  ver = lib.helper.read ./version.json;
in
  stdenvNoCC.mkDerivation (lib.helper.mkDarwin {
    pname = "fluxer-canary-bin";

    src = fetchurl (lib.helper.getSingle ver);
    inherit (ver) version;

    nativeBuildInputs = [unzip];

    meta = {
      description = "Fluxer desktop client (canary)";
      homepage = "https://fluxer.app";
      license = lib.licenses.agpl3Only;
      platforms = lib.platforms.darwin;
      mainProgram = "fluxer-canary-bin";
      maintainers = with lib.maintainers; [WoutFontaine Prinky];
    };
  })
else fluxer-canary-bin

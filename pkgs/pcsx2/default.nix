# NOTE: MacOS version is untested
{
  stdenvNoCC,
  pcsx2-bin,
  fetchurl,
  pcsx2,
  lib,
  ...
}:
if stdenvNoCC.isDarwin
then let
  ver = lib.helper.read ./version.json;
in pcsx2-bin.overrideAttrs (old: {
  src = fetchurl (lib.helper.getSingle ver);

  meta.platforms = lib.platforms.darwin;
})
else pcsx2

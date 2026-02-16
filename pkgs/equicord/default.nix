{
  fetchFromGitHub,
  fetchPnpmDeps,
  equicord,
  pnpm_10,
  lib,
  stdenv,
  ...
}: let
  ver = lib.helper.read ./version.json;
  src = fetchFromGitHub (lib.helper.getSingle ver);
in
  equicord.overrideAttrs (old: rec {
    inherit (ver) version;
    inherit src;

    pnpmDeps = fetchPnpmDeps {
      inherit (old) pname;
      inherit version src;
      pnpm = pnpm_10;
      fetcherVersion = 1;
      hash = let
        h = ver.pnpmHash or "";
      in
        if builtins.isAttrs h
        then h.${stdenv.hostPlatform.system} or (throw "No pnpmHash for system: ${stdenv.hostPlatform.system}")
        else h;
    };

    env =
      old.env
      // {
        EQUICORD_HASH = src.tag;
      };
  })

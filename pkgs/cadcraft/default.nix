# pname = "cadcraft";
# description = "deprecated, use cadcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/cadcraft";
{...}:
throw ''
  cadcraft is deprecated and has been removed from this repository.

  Use cadcraft from nixpkgs (26.11 or unstable) instead: pkgs.cadcraft
''

# pname = "gridcraft";
# description = "deprecated, use gridcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/gridcraft";
{...}:
throw ''
  gridcraft is deprecated and has been removed from this repository.

  Use gridcraft from nixpkgs (26.11 or unstable) instead: pkgs.gridcraft
''

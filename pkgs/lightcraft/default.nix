# pname = "lightcraft";
# description = "deprecated, use lightcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/lightcraft";
{...}:
throw ''
  lightcraft is deprecated and has been removed from this repository.

  Use lightcraft from nixpkgs (26.11 or unstable) instead: pkgs.lightcraft
''

# pname = "filmcraft";
# description = "deprecated, use filmcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/filmcraft";
{...}:
throw ''
  filmcraft is deprecated and has been removed from this repository.

  Use filmcraft from nixpkgs (26.11 or unstable) instead: pkgs.filmcraft
''

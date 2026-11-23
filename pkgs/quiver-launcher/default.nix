# pname = "quiver-launcher";
# description = "deprecated, use quiver-launcher from nixpkgs 26.11 or unstable instead";
# homepage = "https://github.com/tgeorgiadis/quiver-launcher";
{...}:
throw ''
  quiver-launcher is deprecated and has been removed from this repository.

  Use quiver-launcher from nixpkgs (26.11 or unstable) instead: pkgs.quiver-launcher
''

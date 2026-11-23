# pname = "fx";
# description = "deprecated, use fx-sh from nixpkgs 26.11 or unstable instead";
# homepage = "https://fx.sh";
{...}:
throw ''
  fx is deprecated and has been removed from this repository.

  Use fx-sh from nixpkgs (26.11 or unstable) instead: pkgs.fx-sh
''

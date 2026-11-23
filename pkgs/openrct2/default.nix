# pname = "openrct2";
# description = "deprecated, use openrct2 from nixpkgs 26.11 or unstable instead";
# homepage = "https://openrct2.io/";
{...}:
throw ''
  openrct2 is deprecated and has been removed from this repository.

  Use openrct2 from nixpkgs (26.11 or unstable) instead: pkgs.openrct2
''

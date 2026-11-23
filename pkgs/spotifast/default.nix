# pname = "spotifast";
# description = "deprecated, use spotifast from nixpkgs 26.11 or unstable instead";
# homepage = "https://spotifast.rocks/";
{...}:
throw ''
  spotifast is deprecated and has been removed from this repository.

  Use spotifast from nixpkgs (26.11 or unstable) instead: pkgs.spotifast
''

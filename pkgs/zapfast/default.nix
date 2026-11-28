# pname = "zapfast";
# description = "deprecated, use zapfast from nixpkgs 26.11 or unstable instead";
# homepage = "https://zapfast.rocks/";
{...}:
throw ''
  zapfast is deprecated and has been removed from this repository.

  Use zapfast from nixpkgs (26.11 or unstable) instead: pkgs.zapfast
''

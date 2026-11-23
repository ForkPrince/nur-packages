# pname = "vectorcraft";
# description = "deprecated, use vectorcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/vectorcraft";
{...}:
throw ''
  vectorcraft is deprecated and has been removed from this repository.

  Use vectorcraft from nixpkgs (26.11 or unstable) instead: pkgs.vectorcraft
''

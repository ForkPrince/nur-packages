# pname = "photocraft";
# description = "deprecated, use photocraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/photocraft";
{...}:
throw ''
  photocraft is deprecated and has been removed from this repository.

  Use photocraft from nixpkgs (26.11 or unstable) instead: pkgs.photocraft
''

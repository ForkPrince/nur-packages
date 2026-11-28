# pname = "deckcraft";
# description = "deprecated, use deckcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/deckcraft";
{...}:
throw ''
  deckcraft is deprecated and has been removed from this repository.

  Use deckcraft from nixpkgs (26.11 or unstable) instead: pkgs.deckcraft
''

# pname = "wordcraft";
# description = "deprecated, use wordcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/wordcraft";
{...}:
throw ''
  wordcraft is deprecated and has been removed from this repository.

  Use wordcraft from nixpkgs (26.11 or unstable) instead: pkgs.wordcraft
''

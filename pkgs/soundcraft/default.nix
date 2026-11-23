# pname = "soundcraft";
# description = "deprecated, use soundcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/soundcraft";
{...}:
throw ''
  soundcraft is deprecated and has been removed from this repository.

  Use soundcraft from nixpkgs (26.11 or unstable) instead: pkgs.soundcraft
''

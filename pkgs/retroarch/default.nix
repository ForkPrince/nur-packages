# pname = "retroarch";
# description = "deprecated, use retroarch-full from nixpkgs 26.11 or unstable instead";
# homepage = "https://libretro.com";
{...}:
throw ''
  retroarch is deprecated and has been removed from this repository.

  Use retroarch-full from nixpkgs (26.11 or unstable) instead: pkgs.retroarch-full
''

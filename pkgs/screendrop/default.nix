# pname = "screendrop";
# description = "deprecated, use screendrop from nixpkgs 26.11 or unstable instead";
# homepage = "https://github.com/fayazara/screendrop";
{...}:
throw ''
  screendrop is deprecated and has been removed from this repository.

  Use screendrop from nixpkgs (26.11 or unstable) instead: pkgs.screendrop
''

# pname = "tenacity";
# description = "deprecated, use tenacity from nixpkgs 26.11 or unstable instead";
# homepage = "https://tenacityaudio.org/";
{...}:
throw ''
  tenacity is deprecated and has been removed from this repository.

  Use tenacity from nixpkgs (26.11 or unstable) instead: pkgs.tenacity
''

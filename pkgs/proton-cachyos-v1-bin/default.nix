# pname = "proton-cachyos-v1-bin";
# description = "deprecated, use proton-cachyos-bin from nixpkgs 26.11 or unstable instead";
# homepage = "https://github.com/CachyOS/proton-cachyos";
{...}:
throw ''
  proton-cachyos-v1-bin is deprecated and has been removed from this repository.

  Use proton-cachyos-bin from nixpkgs (26.11 or unstable) instead: pkgs.proton-cachyos-bin
''

# pname = "finetune";
# description = "deprecated, use finetune from nixpkgs 26.11 or unstable instead";
# homepage = "https://github.com/ronitsingh10/FineTune";
{...}:
throw ''
  finetune is deprecated and has been removed from this repository.

  Use finetune from nixpkgs (26.11 or unstable) instead: pkgs.finetune
''

# pname = "pdfcraft";
# description = "deprecated, use pdfcraft from nixpkgs 26.11 or unstable instead";
# homepage = "https://getartcraft.com/apps/pdfcraft";
{...}:
throw ''
  pdfcraft is deprecated and has been removed from this repository.

  Use pdfcraft from nixpkgs (26.11 or unstable) instead: pkgs.pdfcraft
''

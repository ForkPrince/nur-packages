# pname = "linearmouse";
# description = "deprecated, use linearmouse from nixpkgs 26.11 or unstable instead";
# homepage = "https://linearmouse.org/";
{...}:
throw ''
  linearmouse is deprecated and has been removed from this repository.

  Use linearmouse from nixpkgs (26.11 or unstable) instead: pkgs.linearmouse
''

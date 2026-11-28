# pname = "ladybird";
# description = "deprecated, use ladybird from nixpkgs 26.11 or unstable instead";
# homepage = "https://ladybird.org";
{...}:
throw ''
  ladybird is deprecated and has been removed from this repository.

  Use ladybird from nixpkgs (26.11 or unstable) instead: pkgs.ladybird
''

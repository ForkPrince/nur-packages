# pname = "crossover";
# description = "deprecated, use crossover from nixpkgs 26.11 or unstable instead";
# homepage = "https://www.codeweavers.com/products/crossover-mac";
{...}:
throw ''
  crossover is deprecated and has been removed from this repository.

  Use crossover from nixpkgs (26.11 or unstable) instead: pkgs.crossover
''

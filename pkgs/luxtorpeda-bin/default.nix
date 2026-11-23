# pname = "luxtorpeda-bin";
# description = "deprecated, use luxtorpeda-bin from nixpkgs 26.11 or unstable instead";
# homepage = "https://github.com/luxtorpeda-dev/luxtorpeda";
{...}:
throw ''
  luxtorpeda-bin is deprecated and has been removed from this repository.

  Use luxtorpeda-bin from nixpkgs (26.11 or unstable) instead: pkgs.luxtorpeda-bin
''

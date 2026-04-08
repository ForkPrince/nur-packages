{
  nix-update-script,
  fetchFromGitHub,
  fetchPnpmDeps,
  equicord,
  pnpm_10,
  ...
}: let
  version = "2026-04-08";

  src = fetchFromGitHub {
    owner = "Equicord";
    repo = "Equicord";
    tag = version;
    hash = "sha256-3wFmi+SzInP+1PH3pwBquTrU757I8z6PmvPxuyygIwU=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (equicord) pname;
    inherit version src;
    pnpm = pnpm_10;
    fetcherVersion = 1;
    hash = "sha256-pmhPRKp1m2ZbpBxPLWBDYEDPphmgO8LVcT9BwW/onJg=";
  };
in
  equicord.overrideAttrs (old: {
    inherit version src pnpmDeps;

    env =
      old.env
      // {
        EQUICORD_HASH = src.tag;
      };

    passthru =
      (old.passthru or {})
      // {
        inherit pnpmDeps;
        updateScript = nix-update-script {
          extraArgs = [
            "--version-regex"
            "^(\\d{4}-\\d{2}-\\d{2})$"
          ];
        };
      };
  })

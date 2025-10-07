{
  fetchFromSourcehut,
  rustPlatform,
  lib,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "nirius";
  version = "0.3.1";

  src = fetchFromSourcehut {
    owner = "~tsdh";
    repo = "nirius";
    rev = "${pname}-${version}";
    hash = "sha256-AfzCsCvqgz8Ff9Fbszt87i2MD/MubLDD1SxsU2be+j4=";
  };

  cargoHash = "sha256-fhYjqQ/09tWW1eRmFbya2a1od1Jg3dSfipaCkwYaVAI=";

  cargoBuildFlags = ["--all-features"];

  installPhase = ''
    runHook preInstall

    for bin in ${pname} ${pname}d; do
      path=$(find target -type f -name "$bin" -executable | head -n1)
      if [ -z "$path" ]; then
        echo "Error: Binary $bin not found in target/"
        exit 1
      fi
      echo "Installing $bin from $path"
      install -Dm755 "$path" "$out/bin/$bin"
    done

    runHook postInstall
  '';

  meta = {
    description = "Utility commands for the niri wayland compositor";
    homepage = "https://sr.ht/~tsdh/nirius/";
    license = lib.licenses.gpl3Plus;
    maintainers = ["Prinky"];
    platforms = lib.platforms.linux;
  };
}

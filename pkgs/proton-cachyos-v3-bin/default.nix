{
  stdenvNoCC,
  fetchzip,
  lib,
}: let
  ver = lib.helper.read ./version.json;
in
  stdenvNoCC.mkDerivation rec {
    pname = "proton-cachyos-v3-bin";
    inherit (ver) version;

    src = fetchzip (lib.helper.getSingle ver);

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    outputs = [
      "out"
      "steamcompattool"
    ];

    installPhase = ''
      runHook preInstall

      # Make it impossible to add to an environment. You should use the appropriate NixOS option.
      # Also leave some breadcrumbs in the file.
      echo "${pname} should not be installed into environments. Please use programs.steam.extraCompatPackages instead." > $out

      mkdir $steamcompattool
      ln -s $src/* $steamcompattool
      rm $steamcompattool/compatibilitytool.vdf
      cp $src/compatibilitytool.vdf $steamcompattool

      runHook postInstall
    '';

    preFixup = ''
      sed -i \
        "s|proton-cachyos-[^\"]*|Proton-CachyOS-v3|g" \
        "$steamcompattool/compatibilitytool.vdf"
    '';

    meta = {
      description = ''
        Compatibility tool for Steam Play based on Wine and additional components

        (This is intended for use in the `programs.steam.extraCompatPackages` option only.)
      '';
      homepage = "https://github.com/CachyOS/proton-cachyos";
      license = lib.licenses.bsd3;
      maintainers = with lib.maintainers; [Prinky];
      platforms = ["x86_64-linux"];
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }

{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
  patchelf,
  copyDesktopItems,
  makeDesktopItem,
  pkgsi686Linux,
}: let
  ver = lib.helper.read ./version.json;

  pname = "halo-ce-universal";
  src = fetchurl (lib.helper.getSingle ver);
  inherit (ver) version;

  isLinux = stdenvNoCC.hostPlatform.isLinux;

  runtimeLibs = lib.optionals isLinux (with pkgsi686Linux; [
    glibc
    libgcc
    sdl3
  ]);

  libPath = lib.makeSearchPath "lib" runtimeLibs;
in
  stdenvNoCC.mkDerivation {
    inherit pname version src;

    sourceRoot = ".";
    unpackCmd = "unzip -qq $curSrc";

    nativeBuildInputs = [
      copyDesktopItems
      patchelf
      unzip
    ];

    buildInputs = runtimeLibs;

    desktopItems = [
      (makeDesktopItem {
        name = pname;
        desktopName = "Halo: Combat Evolved";
        genericName = "First-person shooter";
        comment = "Halo: Combat Evolved ported from the original Xbox decompilation";
        exec = pname;
        terminal = false;
        categories = ["Game"];
      })
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin $out/share/$pname $out/share/licenses/$pname
      install -m755 halo $out/share/$pname/halo
      install -m644 mbedtls-LICENSE.txt extract-xiso-LICENSE.txt miniupnpc-LICENSE.txt Overpass-OFL.txt \
        $out/share/licenses/$pname/

      ${lib.optionalString isLinux ''
        patchelf --set-interpreter ${pkgsi686Linux.glibc}/lib/ld-linux.so.2 \
          --set-rpath "${libPath}" \
          $out/share/$pname/halo
      ''}

      cat > $out/bin/$pname <<EOF
      #!${stdenvNoCC.shell}
      set -e
      game_dir="\''${XDG_DATA_HOME:-\$HOME/.local/share}/$pname"
      stamp="\$game_dir/.nix-version"
      if [ ! -x "\$game_dir/halo" ] || [ "\$(cat "\$stamp" 2>/dev/null)" != "$version" ]; then
        mkdir -p "\$game_dir"
        cp -f "$out/share/$pname/halo" "\$game_dir/halo"
        printf '%s' "$version" > "\$stamp"
      fi
      exec "\$game_dir/halo" "\$@"
      EOF
      chmod +x $out/bin/$pname

      runHook postInstall
    '';

    meta = {
      description = "Halo: Combat Evolved ported to Linux, from the original Xbox decompilation";
      homepage = "https://github.com/cybersecurity/halo-ce-universal";
      license = lib.licenses.cc0;
      maintainers = with lib.maintainers; [Prinky];
      platforms = ["x86_64-linux"];
      mainProgram = pname;
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }

{
  appimageTools,
  fetchurl,
  pkgs,
  lib,
  stdenv,
  undmg,
  ...
}: let
  info = builtins.fromJSON (builtins.readFile ./info.json);

  inherit (info) version;

  platform = lib.getAttr pkgs.stdenv.hostPlatform.system info.platforms;

  filename = lib.replaceStrings ["{version}"] [version] platform.file;
  
  isDarwin = lib.hasSuffix "-darwin" pkgs.stdenv.hostPlatform.system;
in
(if isDarwin then
  stdenv.mkDerivation {
    pname = "helium";

    inherit version;

    src = fetchurl {
      inherit (platform) hash;
      url = "https://github.com/${lib.getAttr pkgs.stdenv.hostPlatform.system info.repos}/releases/download/${info.version}/${filename}";
    };

    nativeBuildInputs = [undmg];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      mkdir -p $out/Applications
      cp -r *.app $out/Applications/

      mkdir -p $out/bin
      ln -s $out/Applications/Helium.app/Contents/MacOS/Helium $out/bin/helium

      runHook postInstall
    '';

    meta = {
      description = "Private, fast, and honest web browser (nightly builds)";
      homepage = "https://github.com/imputnet/helium";
      changelog = "https://github.com/${lib.getAttr pkgs.stdenv.hostPlatform.system info.repos}/releases/tag/${version}";
      license = lib.licenses.gpl3;
      maintainers = ["Ev357" "Prinky"];
      platforms = ["x86_64-darwin" "aarch64-darwin"];
      mainProgram = "helium";
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };
  }
else
  appimageTools.wrapType2 rec {
    pname = "helium";

    inherit version;

    src = fetchurl {
      inherit (platform) hash;
      url = "https://github.com/${lib.getAttr pkgs.stdenv.hostPlatform.system info.repos}/releases/download/${info.version}/${filename}";
    };

    extraInstallCommands = let
      contents = appimageTools.extract {inherit pname version src;};
    in ''
      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop --replace-fail 'Exec=AppRun' 'Exec=${meta.mainProgram}'

      cp -r ${contents}/usr/share/* $out/share/

      install -d $out/share/lib/${pname}
      cp -r ${contents}/opt/${pname}/locales $out/share/lib/${pname}/
    '';

    meta = {
      description = "Private, fast, and honest web browser (nightly builds)";
      homepage = "https://github.com/imputnet/helium";
      changelog = "https://github.com/${lib.getAttr pkgs.stdenv.hostPlatform.system info.repos}/releases/tag/${version}";
      license = lib.licenses.gpl3;
      maintainers = ["Ev357" "Prinky"];
      platforms = ["x86_64-linux" "aarch64-linux"];
      mainProgram = "helium";
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };
  })

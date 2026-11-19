{
  fetchurl,
  lib,
}: let
  ver = lib.helper.read ./version.json;

  pname = "nexus-launcher";
  inherit (ver) version;
  src = fetchurl (lib.helper.getSingle ver);

  meta = {
    description = "Open-source Xbox-inspired launcher for Microsoft Store games on Linux";
    longDescription = ''
      Nexus Launcher is an independent, unofficial Xbox-inspired desktop
      launcher for playing Microsoft Store games on Linux, built on top of
      Xodus. It provides a game library, store, cloud saves and controller
      support.
    '';
    homepage = "https://github.com/domsvoboda/nexus-launcher";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [Prinky];
    platforms = ["x86_64-linux"];
    mainProgram = pname;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
in
  lib.helper.mkAppImage {
    inherit pname version src meta;

    desktopName = "Nexus Launcher";
    desktopId = "xodus-nexus";
    exec = "${pname} --no-sandbox %U";
    icon = "xodus-nexus";
    startupWMClass = "Nexus Launcher";
    categories = ["Game"];
  }

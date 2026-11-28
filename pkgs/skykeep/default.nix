{
  fetchurl,
  lib,
}: let
  ver = lib.helper.read ./version.json;
in
  lib.helper.mkAppImage rec {
    pname = "skykeep";

    src = fetchurl (lib.helper.getSingle ver);
    inherit (ver) version;

    desktopId = "io.github.yashwanthkamireddi.Skykeep";
    desktopName = "Skykeep";
    desktopComment = "Your iCloud, on this computer";
    icon = "skykeep";
    categories = ["Office"];
    startupWMClass = "io.github.yashwanthkamireddi.Skykeep";
    extraDesktopItem = {
      genericName = "iCloud Client";
      keywords = ["iCloud" "calendar" "reminders" "notes" "contacts" "sync"];
      mimeTypes = ["text/calendar" "text/vcard" "text/x-vcard"];
      startupNotify = true;
      actions = {
        new-reminder = {
          name = "New Reminder";
          exec = "skykeep --new reminder";
        };
        new-note = {
          name = "New Note";
          exec = "skykeep --new note";
        };
        notes = {
          name = "Notes";
          exec = "skykeep --app notes";
        };
        reminders = {
          name = "Reminders";
          exec = "skykeep --app reminders";
        };
        calendar = {
          name = "Calendar";
          exec = "skykeep --app calendar";
        };
        contacts = {
          name = "Contacts";
          exec = "skykeep --app contacts";
        };
        drive = {
          name = "Drive";
          exec = "skykeep --app drive";
        };
        photos = {
          name = "Photos";
          exec = "skykeep --app photos";
        };
      };
    };

    meta = {
      description = "Native iCloud client for Notes, Reminders, Calendar, Contacts, Drive and Photos";
      homepage = "https://github.com/YashwanthKamireddi/Skykeep";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [Prinky];
      platforms = ["x86_64-linux"];
      mainProgram = pname;
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }

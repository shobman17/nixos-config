{ config, lib, pkgs, ... }:
let
  dataDir = "/var/lib/syncthing";
  user = "syncthing";
  group = "syncthing";
in {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    overrideFolders = true;
    overrideDevices = true;
    inherit dataDir;
# Optional: GUI credentials (can be set in the browser instead if you don't want plaintext credentials in your configuration.nix file)
# or the password hash can be generated with "syncthing generate --config <path> --gui-password=<password>"
    settings = {
      gui = {
        user = "shob";
      };

      devices = {
        "ShobPlus" = {id = "OK6KDGV-4BKNPQ7-6AHGV6H-P5YRTMG-PRIDJAZ-V3ZHRMP-WXQW7NO-WT43BAB";};
      };

      folders = {
        "WhatsApp_Backup" = {
          path = "${dataDir}/backups/WhatsApp";
          devices = ["ShobPlus"];
          type = "receiveonly";
          id = "fgk3w-hdc0q";
        };

        "MusicOC" = {
          path = "${dataDir}/share/MusicOC";
          devices = ["ShobPlus"];
          type = "sendreceive";
          id = "w7hbl-kxixg";
        };

        "GBA_games" = {
          path = "${dataDir}/share/Games/GBA";
          devices = ["ShobPlus"];
          type = "sendreceive";
          id = "jp759-4up6r";
        };

        "RetroArch_saves" = {
          path = "${dataDir}/share/Games/retroarch/saves";
          devices = ["ShobPlus"];
          type = "sendreceive";
          id = "qmyw3-zmxba";
          copyOwnershipFromParent = true;
        };

      };
    };

# key = "/var/lib/syncthing/syncConfig/key.pem";
# cert = "/var/lib/syncthing/syncConfig/cert.pem";
# LOOK INTO RELAY SERVERS
  };

  systemd.tmpfiles.rules = [
    "d ${dataDir} 0750 ${user} ${group}"
    "Z ${dataDir}/share 0770 ${user} ${group}" #RW folder 
    "Z ${dataDir}/backups 0750 ${user} ${group}" #only read folder
    "d ${dataDir}/.config 0700 ${user} ${group}"

    "L+ /home/shob/Music/MusicOC - - - - ${dataDir}/share/MusicOC"
    "L+ /home/shob/Games/GBA - - - - ${dataDir}/share/Games/GBA"
    "L+ /home/shob/.config/retroarch/saves - - - - ${dataDir}/share/Games/retroarch/saves"
  ];

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

}


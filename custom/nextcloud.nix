{config, pkgs, lib, ...}: 
let 
  storageLocation = "/var/lib/nextcloud";
  host = "localhost";
  serverIP = "192.168.0.169";
  internalPort = 8080;


in {

  environment.etc."nextcloud-admin-pass".text = "DarkHelix007!";
  
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = host;
    home = storageLocation;

    config.adminuser = "shobAdmin";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";

    extraAppsEnable = true;
    autoUpdateApps.enable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };

    configureRedis = true;

    #database.createLocally = true;

    maxUploadSize = "1G";

    settings.trusted_domains = ["192.168.0.169"];


  };

  # Create storage directory
  systemd.tmpfiles.rules = [
    "d ${storageLocation} 0750 nextcloud nextcloud"
  ];

  # configure IP and port
  services.nginx.virtualHosts."${host}".listen = [
    {
      addr = "${serverIP}"; 
      port = internalPort;
    }
  ];

}

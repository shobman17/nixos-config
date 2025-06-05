{ config, lib, pkgs, ... }:
let
  photosLocation = "/var/lib/immich";
  host = "0.0.0.0"; 
  port = 8084;  # Immich internal port
  serverLocalIP = "192.168.0.169"; # this is hard set from the router
  domain = "what do i put here";
in {
  # Immich Service Configuration
  services.immich = {
    enable = true;
    inherit port;
    inherit host;
    mediaLocation = photosLocation;
    settings = {
      # publicUrl = "https://${domain}";
      storageTemplate.enabled = true;
      metadata.faces.import = true;
      newVersionCheck.enabled = false;
    };
    openFirewall = true;
    redis.enable = true;
  };
}

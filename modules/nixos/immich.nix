
{ config, lib, pkgs, ... }:

let
  photosLocation = "/var/lib/immich";
  host = "0.0.0.0"; 
  port = 8084;  # Immich internal port
  serverLocalIP = "192.168.0.169";
  domain = "immich.local";
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
  };

  # Create photos directory
  systemd.tmpfiles.rules = [
    "d ${photosLocation} 0750 ${config.services.immich.user} ${config.services.immich.group}"
  ];

  # Networking Configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ port ];  # Allow HTTP(S) traffic
  };

  # Caddy Reverse Proxy Configuration
  # services.caddy = {
  #   enable = true;
  #   email = "shobhitmaheshwari2003@gmail.com";
  #   virtualHosts."${domain}" = {
  #     extraConfig = ''
  #       tls internal
  #       reverse_proxy ${host}:${toString port}
  #     '';
  #   };
  # };

  # Enable Avahi for mDNS (.local domain resolution)
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true; # Allow Avahi to resolve .local domains
  #   nssmdns6 = true; # Allow Avahi to resolve .local domains over IPv6
  #   publish = {
  #     enable = true;
  #     addresses = true; # Publish the machine's IP address
  #     domain = true; # Publish the local domain
  #     #workstation = true;
  #     #userServices = true;
  #   };
  # };

  # # Local DNS Resolution
  # services.dnsmasq = {
  #   enable = true;
  #   settings = {
  #     interface = "";
  #     domain-needed = true;
  #     address = [
  #       "/${domain}/${serverLocalIP}"
  #     ];
  #     server = [ # act as DNS forwarder if domain not in address list defined above
  #       "8.8.8.8"  # Google DNS
  #       "1.1.1.1"  # Cloudflare DNS
  #     ];
  #   };
  # };
}

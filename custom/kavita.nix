{ config, lib, pkgs, ... }:

let
  mediaLocation = "/var/lib/kavita";
  host = "0.0.0.0"; 
  port = 6969;  # kavita internal port
  serverLocalIP = "192.168.0.169";
in {

  environment.etc."kavita-token".text = "r8nJO4H6tyXglzD0NtZQIPbuB7L7TyBi+PRtVcVLNpvEOtW6YZavjCIre3WGFWxY/dqhpjA+TCyGeI71a2NfNA==";

  services.kavita = {
    enable = true;
    dataDir = mediaLocation;
    tokenKeyFile = "/etc/kavita-token";
    settings = {
        Port = port;
        IpAddresses = host;
      };
  };

  # Networking Configuration
  networking.firewall = {
    allowedTCPPorts = [ port ];  
  };
}



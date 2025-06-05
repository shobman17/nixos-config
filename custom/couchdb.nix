{ config, pkgs, ... }:
let
  internalPort = 5984;
  host = "0.0.0.0";
  mediaLocation = "/var/lib/couchdb";
in 

{
  # Enable CouchDB
  services.couchdb = {
    enable = true;
    port = internalPort;
    adminUser = "shobAdmin";
    adminPass = "power123";
    bindAddress = host;
    databaseDir = mediaLocation;
    viewIndexDir = mediaLocation;
  };

  # Set environment variables
  # environment.variables = {
  #   PUID = "99";
  #   PGID = "100";
  #   UMASK = "0022";
  #   TZ = "America/New_York";
  #   COUCHDB_USER = "obsidian_user";
  #   COUCHDB_PASSWORD = "password";
  # };

  # Open the required port
  networking.firewall.allowedTCPPorts = [ internalPort ];

  # manage permissions
  systemd.tmpfiles.rules = [
    "d ${mediaLocation} 0750 ${config.services.couchdb.user} ${config.services.couchdb.group}"
  ];


  # Optional: Add labels (not directly supported in NixOS, but you can add comments)
  # Labels:
  # - net.unraid.docker.webui=http://[IP]:[PORT:5984]/_utils
  # - net.unraid.docker.icon=https://couchdb.apache.org/image/couch@2x.png
  # - net.unraid.docker.shell=bash

  # Ensure the service restarts unless stopped
  # systemd.services.couchdb = {
  #   serviceConfig = {
  #     Restart = "unless-stopped";
  #   };
  # };
}

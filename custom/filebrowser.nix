{pkgs, ...}: 

let 
  instance_name = "filebrowser";
  user = "filebrowser";
  group = "filebrowser";
  host = "0.0.0.0";
  port = 3030;
  dataDir = "/var/lib/filebrowser";
in {

  users.users.${user} = {
    description = "FileBrowser User";
    isSystemUser = true;
    group = "${group}";
    home = dataDir;
  };

  users.groups.${group} = {};
  
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0750 ${user} ${group}"
    "d ${dataDir}/storage 0750 ${user} ${group}"
  ];

  systemd.services.${instance_name} = {
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      User = "${user}";
      Group = "${group}";
      WorkingDirectory = "${dataDir}";
      Restart = "on-failure";
      RestartSec = "5";
      ExecStartPre = pkgs.writeShellScript "init-${instance_name}" ''
        # Check if database exists, if not initialize it
        if [ ! -f "${dataDir}/filebrowser.db" ]; then
          ${pkgs.filebrowser}/bin/filebrowser config init --database "${dataDir}/filebrowser.db"
        fi
        
        # Configure filebrowser
        ${pkgs.filebrowser}/bin/filebrowser config set \
          --database "${dataDir}/filebrowser.db" \
          --branding.name "Shob Drive" \
          --address "${host}" \
          --port "${toString port}" \
          --root "${dataDir}/storage"

        # Check if admin user exists, if not create it
        # This is a bit hacky but works - we check if the command to list users contains "admin"
        if ! ${pkgs.filebrowser}/bin/filebrowser users ls --database "${dataDir}/filebrowser.db" | grep -q "admin"; then
          ${pkgs.filebrowser}/bin/filebrowser users add admin password --database "${dataDir}/filebrowser.db" --perm.admin
          echo "Admin user created"
        else
          echo "Admin user already exists"
        fi
      '';
    
      ExecStart = ''
        ${pkgs.filebrowser}/bin/filebrowser
        # --database "${dataDir}/filebrowser.db" \
        # --address "${host}" \
        # --port ${toString port} \
        # --root "${dataDir}/storage"
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ port ];

  }

{config, lib, ...}:

{
  networking = {

    hostName = "nixos";
    networkmanager.enable = true;
    # networkmanager.dns = "dnsmasq"; # helps in routing domains to this IP
    
    # Open standard HTTP/HTTPS ports
    firewall.allowedTCPPorts = [ 80 443 ];
    
    # Add static IP configuration for the ethernet interface
    # interfaces.eno1.ipv4.addresses = [{
    #   address = "192.168.0.117";
    #   prefixLength = 24;
    # }];

    # defaultGateway = "192.168.0.1";  # Local router's IP
  };

  services.caddy.enable = true;

  services.dnsmasq.enable = true;
}

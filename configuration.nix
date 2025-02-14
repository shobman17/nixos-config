
{ inputs, outputs, config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/nixos/gaming.nix
      ./modules/nixos/immich.nix
      #./modules/nixos/couchdb.nix
      #./modules/nixos/kavita.nix
      inputs.elanmoc2.nixosModules.elanmoc2
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-063945f9-1083-440e-8187-fbb8357f811b".device = "/dev/disk/by-uuid/063945f9-1083-440e-8187-fbb8357f811b";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable multi touch gestures
  services.touchegg.enable = true;

  # Enable fingerprint scanner
  services.fprintd.elanmoc2.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shob = {
    isNormalUser = true;
    description = "Shobhit Maheshwari";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner"];
    packages = with pkgs; [
      home-manager
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # enable virt-d virtualisation
  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;
  # users.extraGroups.docker.members = ["shob"];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
    [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      #linuxPackages_latest.perf
      msr-tools
      gnumake
      gcc
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  
  # Remap keys
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  # setup automatic garbage collection and flakes
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
      persistent = true;
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };
  
  # Prevent laptop from sleepign when on AC power and lid is closed
  services.logind.lidSwitchExternalPower = "suspend";

  # VPN services 
  programs.openvpn3 = {
      enable = true;
  };

  # To run appimages 
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;

}

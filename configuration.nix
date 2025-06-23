
{ inputs, outputs, config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./custom/gaming.nix
      ./custom/battery_optimisations.nix
      ./custom/immich.nix
      # ./custom/kavita.nix
      ./custom/syncthing.nix
      # ./custom/paperless.nix
      ./custom/theme_common.nix
      ./custom/theme_nixos.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelParams = [ 
                        # "splash"
                        "nmi_watchdog=0"
                        "quiet"
                        "intel_pstate=disable"
                        ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=1
  '';
  # boot.kernel.sysctl = {
  #   "vm.dirty_writeback_centisecs" = 6000;
  #   "vm.laptop_mode" = 5;
  # };
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen; # for desktop usecases ig

  # boot.initrd.luks.devices."luks-063945f9-1083-440e-8187-fbb8357f811b".device = "/dev/disk/by-uuid/063945f9-1083-440e-8187-fbb8357f811b";
  
  # For a fancy splash screen at the start
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  # Enable the Cosmic Desktop Environment.
  # services.displayManager.cosmic-greeter.enable = true;
  # services.desktopManager.cosmic.enable = true;

  # autologin and fix
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "shob";
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  environment.gnome.excludePackages = with pkgs; [
    epiphany # web browser
    gedit # text editor
    geary # email 
    gnome-music
    gnome-console
    gnome-photos
    gnome-tour
  ];

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
  # services.fprintd.elanmoc2.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" "syncthing"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
    outputs.overlays.stable-packages
  ];
  
  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
    [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    # settings.auto-optimise-store = true; # this optimises store on every build
    optimise = {
      automatic = true;
      dates = ["Mon 05:00"];
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "Mon 04:00";
      options = "--delete-older-than 4d";
    };

    settings.download-buffer-size = 524288000;
  };
  
  # Prevent laptop from sleepign when on AC power and lid is closed
  services.logind.lidSwitchExternalPower = "suspend";

  # VPN services 
  programs.openvpn3 = {
      enable = true;
  };

  programs.nix-ld.enable = true;

  # sigh.... lets make the boot time smaller
  # Disable this wait online thing which just makes the laptop sit for ~6s
  systemd.services.NetworkManager-wait-online.wantedBy = [];
  # Disable showing the generation select screen on boot unless you hold SPACEBAR
  boot.loader.timeout = 0;
  # limit storage of journald 
  services.journald.extraConfig = "SystemMaxUse=50M";

  services.usbmuxd.enable = true;

}

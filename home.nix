{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
    ./custom/terminal.nix
    ./custom/theme_rose-pine-moon.nix
    ./custom/theme_rose-pine-moon_extras.nix
  ];

  home.username = "shob";
  home.homeDirectory = "/home/shob";

  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
    outputs.overlays.stable-packages
  ];

  home.packages = with pkgs; [

    # screen savers and terminal tricks and shi
    cmatrix
    sl
    pipes
    tenki
    cbonsai
    cowsay
    asciiquarium-transparent
    krabby
    stable.pokemonsay
    stable.fortune

    # useful terminal tools
    lf
    fzf
    xsel
    dmidecode
    fastfetch
    bat
    killall
    imagemagick
    usbutils
    pciutils
    zip
    unzip

    # acad apps
    #distrobox
    obsidian
    kdePackages.okular
    pdfarranger
    sioyek
    #pkgs22.quartus-prime-lite # hoo boy
    # eagle
    rar
    # kicad
    teams-for-linux

    # gnome extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dock-from-dash
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.peek-top-bar-on-fullscreen

    # lua
    lua

    # browser
    brave

    # gaming
    wine 
    stable.bottles
    #winetricks
    #protontricks
    lutris
    stable.desmume
    mgba


    # python (should move this to a nix shell)
    # python312

    # Java
    jdk17

    # multimedia processing
    puddletag
    ffmpeg
    vlc
    amberol
    gimp
    kdenlive

    # Syncing
    syncthing 

    # FPGA design
    iverilog
    verilator
    gtkwave
    ghdl

    # misc 
    immich-go

  ];

  home.file = {
  };

  home.sessionVariables = {
    TEST_VAR = 1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # NeoVim config lessgoo
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # git config oof
  programs.git = {

    enable = true;
    userName = "shobman17";
    userEmail = "210070081@iitb.ac.in";

    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };

  };

 
  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      # vscode-extensions.ms-azuretools.vscode-docker
    ];
  };

  programs.obs-studio = {
    enable = true;
  };
  
  # lazy made me
  programs.ripgrep.enable = true;
  programs.lazygit.enable = true;
  programs.fd.enable = true;
  

  # dconf settings for gnome
  dconf = {

    enable = true;

    settings = {
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty" = {
        binding = "<Primary><Alt>t";
        command = "kitty";
        name = "open-kitty";
      };

      "org/gnome/shell" = {
        disable-user-extension = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          dash-to-dock.extensionUuid
          bluetooth-battery-meter.extensionUuid
          peek-top-bar-on-fullscreen.extensionUuid
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/"
        ];
      };

    };
  };

}

{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ./custom/terminal.nix
    ./custom/theme_material_common.nix
    ./custom/theme_material_hm.nix
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
    pokemonsay
    fortune

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
    distrobox
    obsidian
    kdePackages.okular
    pdfarranger
    sioyek
    rar
    teams-for-linux

# gnome extensions
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.logo-menu
    gnomeExtensions.window-title-is-back
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.media-controls
    gnomeExtensions.top-bar-organizer
    gnomeExtensions.open-bar
    gnomeExtensions.window-gestures
    gnomeExtensions.user-themes

# lua
    lua

# browser
    brave
    inputs.zen-browser.packages.${pkgs.system}.default
    browsers

# gaming
    wine 
    (retroarch.withCores (
      cores: with cores; [
        vba-m 
        desmume
        swanstation
        pcsx2
      ]
    ))
    hmcl

# python (should move this to a nix shell)
# python312

# Java
    jdk17

# multimedia processing
    puddletag
    ffmpeg
    vlc
    gimp
    kdePackages.kdenlive
    handbrake

# misc 
    immich-go
    powertop
    beeper
    nix-search-tv
    qbittorrent
    discord

  ];

  home.file = {
  };

  home.sessionVariables = {
    TEST_VAR = 1;
  };

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.home-manager.autoExpire = {
    enable = true;
    frequency = "monthly";
    timestamp = "-30 days";
    store = {
      cleanup = true;
      options = "--delete-older-than 30d";
    };
  };

# NeoVim config lessgoo
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.neovide = {
    enable = true;
    settings = {

      font = {
        normal = ["JuliaMono"];
        size = 11.0;
      };

      box-drawing = {
        mode = "font-glyph";
      };

      maximised = true;
      fork = true;
      frame = "none";

    };
  };

  programs.lutris.enable = true;

  programs.tmux.enable = true;

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
    package = pkgs.vscodium;
  };

  programs.obs-studio = {
    enable = true;
  };

# lazy made me
  programs.ripgrep.enable = true;
  programs.lazygit.enable = true;
  programs.fd.enable = true;

# custom app entries
  xdg.desktopEntries."beepertexts" = {
    name = "Beeper";
    exec = "beeper --no-sandbox %U";
    icon = "beeper";
    comment = "The ultimate messaging app";
    categories = ["Network"];
    type = "Application";
  };

  xdg.desktopEntries."sioyek" = {
    name = "Sioyek";
    exec = "sioyek %f";
    icon = "bookreader";
    comment = "PDF viewer for reading research papers and technical books";
    categories = ["Development" "Viewer"];
    type = "Application";
  };

  xdg.desktopEntries."com.libretro.RetroArch" = {
    name = "RetroArch";
    exec = "retroarch";
    icon = "retroarch";
    comment = "Frontend for emulators, game engines and media players";
    categories = ["Game" "Emulator"];
    type = "Application";
  };

  xdg.desktopEntries."HMCL" = {
    name = "HMCL";
    exec = "hmcl";
    icon = "minecraft";
    comment = "A Minecraft Launcher which is multi-functional, cross-platform and popular";
    categories = ["Game"];
    type = "Application";
  };

  xdg.desktopEntries."zen" = {
    name = "Zen Browser";
    exec = "zen --name zen %U";
    icon = "zen-browser";
    categories = ["Network" "WebBrowser"];
    type = "Application";
  };

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
            logo-menu.extensionUuid
            window-title-is-back.extensionUuid
            clipboard-indicator.extensionUuid
            media-controls.extensionUuid
            top-bar-organizer.extensionUuid
            open-bar.extensionUuid
            screenshot-window-sizer.extensionUuid
            window-gestures.extensionUuid
            user-themes.extensionUuid
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/"
        ];
      };

      "org/gnome/gnome-session" = {
        logout-prompt = false;    
      };

    };
  };

}

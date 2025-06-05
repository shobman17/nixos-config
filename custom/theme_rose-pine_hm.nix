{pkgs, config, ...}: 
let 
  face-image = pkgs.fetchFromGitHub {
    owner = "shobman17";
    repo = "wallpapers";
    rev = "f31214d16b2b115b5b2c9be742a5aa1be0c19be3";
    hash = "sha256-sW1tSy2pvjbaYa4HEYWSZI6SRtryZWiBYA0OaPxwJys=";
  } + "/egg.png";

in {

  # home.file."~/.face" = face-image;

  stylix = {
    
    targets.neovim.enable = false;
    targets.kitty.variant256Colors = true;


    iconTheme = {
      enable = true;
      package = pkgs.rose-pine-icon-theme;
      dark = "rose-pine";
    };
  };
}

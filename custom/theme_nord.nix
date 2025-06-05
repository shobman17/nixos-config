{ pkgs, ... }: 

let 
  image-src = pkgs.fetchFromGitHub {
      owner = "shobman17";
      repo = "wallpapers";
      rev = "fb9805c484ce5d2bdbb377dd38562022a0f7fa9c";
      hash = "sha256-kg7imE7NigIT6PUIWJUxZxPjaAbEVmHcgvQfYA3ycmw=";
    } + "/a_man_and_a_robot_standing_in_a_parking_lot.jpg";

in {

  gtk.enable = true;
  qt.enable = true;

  stylix = {

    enable = true;
    image = image-src;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";
    targets.neovim.enable = false;
    targets.helix.enable = false;

    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Nord) - White";
      size = 32;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-nord;
      dark = "Papirus-Dark";
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.julia-mono;
        name = "JuliaMono-Regular";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10;
        terminal = 10;
        desktop = 10;
        popups = 10;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.9;
      desktop = 1.0;
      popups = 1.0;
    };

  };

}

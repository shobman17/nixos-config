{pkgs, config, lib, ...}: 

let

  theme = "${pkgs.base16-schemes}/share/themes/material-darker.yaml";
  
in {

  stylix = {
    
    enable = true;
    image = null;
    base16Scheme = theme;
    polarity = "dark";

    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Palenight) - White";
      size = 32;
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
        # package = pkgs.nerd-fonts.sauce-code-pro;
        # name = "";
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

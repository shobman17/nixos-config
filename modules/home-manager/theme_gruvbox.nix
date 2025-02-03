{ pkgs, ... }: {

  gtk.enable = true;
  qt.enable = true;

  stylix = {

    enable = true;
    image = pkgs.fetchurl {
        url = "https://i.pinimg.com/736x/dc/56/ac/dc56ac8d380587a1e60509e393788032.jpg";
        sha256 = "sha256-+g7mXb7EHa1y6/Z+OIW5WEAzzJ8vaypV3sprjD4kMCw";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    
    targets.neovim.enable = false;
    targets.helix.enable = false;

    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox) - White";
      size = 32;
    };
    
    iconTheme = {
      enable = true;
      package = pkgs.gruvbox-plus-icons;
      dark = "Gruvbox-Plus-Dark";
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

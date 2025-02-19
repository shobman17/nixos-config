{pkgs, config, ...}: 

let

  theme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

  image-src-shob = pkgs.fetchFromGitHub {
      owner = "shobman17";
      repo = "wallpapers";
      rev = "fb9805c484ce5d2bdbb377dd38562022a0f7fa9c";
      hash = "sha256-kg7imE7NigIT6PUIWJUxZxPjaAbEVmHcgvQfYA3ycmw=";
    } + "/an_astronaut_playing_a_piano.png";

  image-src-monterey = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "WhiteSur-wallpapers";
      rev = "06f522be3657cab4e2939b5ecab269242c731abe";
      hash = "sha256-BKWk8KnCWfKwf0I2oz9RDlQFtfjyJidkDQLwLMVwyXo=";
    } + "/1080p/Monterey.jpg";

in {

  gtk.enable = true;

  stylix = {
    
    enable = true;
    image = image-src-monterey;
    base16Scheme = theme;
    polarity = "dark";
    targets.neovim.enable = false;

    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Palenight) - White";
      size = 32;
    };

    iconTheme = {
      enable = true;
      package = pkgs.rose-pine-icon-theme;
      dark = "rose-pine";
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

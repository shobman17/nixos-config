{pkgs, config, lib, ...}: 

let

  theme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

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

  image-src-rose-pine = pkgs.fetchFromGitHub {
      owner = "rose-pine";
      repo = "wallpapers";
      rev = "e3d960d956c0d8dced14152e6df1c76b7ed3e7d2";
      hash = "sha256-/+A5cvgBZ027/zmc04Ew2yus3qJVEQoys5d6ciZvZYs=";
    } + "/moon.jpg";

in {

  stylix = {
    
    enable = true;
    image = null;
    base16Scheme = theme;
    polarity = "dark";
    # targets.qt.platform = lib.mkForce "qt5ct";

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

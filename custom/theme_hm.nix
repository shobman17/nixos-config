{pkgs, config, ...}: 

{

  stylix = {
    
    targets.neovim.enable = false;
    targets.kitty.variant256Colors = true;
    targets.vscode.enable = false;
    targets.gnome.enable = false;

    iconTheme = {
      enable = true; 
      package = pkgs.whitesur-icon-theme.override {
          alternativeIcons = true;
          boldPanelIcons = true;
        };
      dark = "WhiteSur-dark";
      light = "WhiteSur-light";
    };
  };

}

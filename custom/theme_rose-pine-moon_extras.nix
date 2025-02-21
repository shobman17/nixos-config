{pkgs, config, ...}: 

{
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

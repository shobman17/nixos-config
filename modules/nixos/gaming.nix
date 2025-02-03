{config, pkgs, ...}: {

  # enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Steam and fellow optimizations
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  
}

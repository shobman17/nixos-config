{pkgs, config, ...}: {

  stylix = {
  
    targets.grub.useImage = true;
    targets.chromium.enable = false;
    targets.plymouth = {
      enable = true;
      logoAnimated = true;
    };
  };
}

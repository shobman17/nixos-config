
{ config, lib, pkgs, ... }:

{
  # System76 OS scheduler. Apparently more efficient?
  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
  };

  # thermald for intel CPUs
  services.thermald.enable = true;

  # don't allow user to change power governer setting
  services.power-profiles-daemon.enable = false;

  # power governer settings
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "schedutil";
      turbo = "auto";
    };
    charger = {
      governor = "schedutil";
      turbo = "auto";
    };
  };

  # more power management lol. Not really needed
  powerManagement = {
    enable = true;
    # powertop.enable = true;
  };
}

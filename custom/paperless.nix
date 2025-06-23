{ config, lib, pkgs, ... }:
let
  dataDir = "/var/lib/paperless";
  port = 28981;
  host = "localhost";
  
in {

  environment.etc."paperless-admin-pass".text = "test-password";

  services.paperless = {
    enable = true;
    inherit dataDir;
    inherit port;
    address = host;
    consumptionDirIsPublic = true;
    exporter = {
      enable = true;
    };
    passwordFile = "/etc/paperless-admin-pass";
    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_OCR_LANGUAGE = "eng";
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };
    };
  };
}

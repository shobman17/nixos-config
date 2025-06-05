# This file defines overlays
{inputs, ...}: 

{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    
    # not needed cause of bump to 5.034
    # verilator = prev.verilator.overrideAttrs (oldAttrs: rec {
    #   pname = "verilator";
    #   version = "5.032";

    #   VERILATOR_SRC_VERSION = "v${version}";
    #   
    #   src = prev.fetchFromGitHub {
    #     owner = "${pname}";
    #     repo = "${pname}";
    #     rev = "v${version}";
    #     hash = "sha256-eIVXljZcloMKzxXnddN+bkJWcp+0dd0/YmzJOa7iioU=";
    #   };

    #   doCheck = false; # checks break with this version. Oh well

    #   VERBOSE = "1";

    # });

  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

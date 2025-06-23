{
  description = "A very basic flake for a basic bitch";

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elanmoc2 = {
      url = "github:sandptel/elanmoc2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-xilinx = {
      url = "gitlab:doronbehar/nix-xilinx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 

      system = "x86_64-linux";
      inherit (self) outputs; # clean this up maybe?

    in {

      # Custom overlays
      overlays = import ./overlays {inherit inputs;};

      packages = import ./pkgs nixpkgs.legacyPackages.${system};

      # Output for the system configuration 
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./configuration.nix
            inputs.elanmoc2.nixosModules.elanmoc2
            inputs.stylix.nixosModules.stylix 

          ];
        };
      };

      # Output for the home manager configuration
      homeConfigurations = {
        "shob@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [ 
            ./home.nix
            inputs.stylix.homeModules.stylix
          ];
        };
      };

  };
}

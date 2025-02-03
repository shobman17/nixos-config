{
  description = "A very basic flake for a basic bitch";

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    elanmoc2.url = "github:sandptel/elanmoc2";

  };


  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (self) outputs; # clean this up maybe?

    in {

      # Custom overlays
      overlays = import ./overlays {inherit inputs;};
      
      # Output for the system configuration 
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./configuration.nix
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
          ];
        };
      };

  };
}

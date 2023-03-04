{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    picom.url = "github:yaocccc/picom";
    flake-utils.url = "github:numtide/flake-utils";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
         nix = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nix = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}


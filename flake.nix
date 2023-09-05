{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  #  picom.url = "github:yaocccc/picom";
    flake-utils.url = "github:numtide/flake-utils";
    hyprland.url = "github:hyprwm/Hyprland";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, hyprland , home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
       config.permittedInsecurePackages = [
                "electron-21.4.0"
              ];
             };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
         shousuke = lib.nixosSystem {
          inherit system pkgs;
          modules = [
             ./configuration.nix

          hyprland.nixosModules.default
            {
              programs.hyprland.enable = true;
	      programs.hyprland.enableNvidiaPatches=false;
              programs.hyprland.xwayland.enable=true;
	      }

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shousuke = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };

}


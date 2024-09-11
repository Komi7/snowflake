{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
 #   nixosConfigurations = {
 #     hostname = nixpkgs.lib.nixosSystem {
 #       system = "x86_64-linux";
 
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
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shousuke = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}

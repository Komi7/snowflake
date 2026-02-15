{
  description = "KOMI Professional Modular NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # System Rebuild: sudo nixos-rebuild switch --flake .#KOMI
    nixosConfigurations.KOMI = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/KOMI/configuration.nix ];
    };
    # User Rebuild: home-manager switch --flake .#shousuke
    homeConfigurations."shousuke" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./modules/home/home.nix ];
    };
  };
}

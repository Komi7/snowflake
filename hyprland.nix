{ pkgs, ... }:

{
  # Only system-level stuff here
  programs.hyprland.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}

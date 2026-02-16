{ pkgs, ... }:

{
  imports = [
    ./waybar.nix  
    ./hyprland.nix
    ./zsh.nix
    ./wlogout.nix
    ./cursor.nix
    ./thunar.nix
  ];
  
  home.username = "shousuke";
  home.homeDirectory = "/home/shousuke";
  home.stateVersion = "25.11";

  # Packages for Shousuke
  home.packages = with pkgs; [
   #for hyprladn
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpicker
    rofi
    copyq
    swww
    dunst
    feh
    swaybg
    grim
    slurp
    wl-clipboard
    brightnessctl
    swaynotificationcenter # Better than Dunst for modern Wayland
    nwg-look               # GTK theme switcher
    qt6Packages.qt6ct                  # Qt theme switcher
 # Audio
    pavucontrol
    wireplumber
    #Fonts
    nerd-fonts.jetbrains-mono
  ];

  programs.home-manager.enable = true;
}

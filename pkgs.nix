{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave     #browser
    rustdesk-flutter  #desktop share
    xdg-desktop-portal
    mpv
  ];
  }

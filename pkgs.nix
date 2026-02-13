{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave     #browser
    rustdesk-flutter  #desktop share
    xdg-desktop-portal
    mpv  #Video Player
    dnsutils #DNS Utilis
    cmake
    clang
    fastfetch #rice
    geany  #Txt Edittor
  ];
  }

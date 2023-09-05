{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "shousuke";
  home.homeDirectory = "/home/shousuke";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
    home.packages = with pkgs; [
	      git
  ];
  # You can update Home Manager without changing this value. Se
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #FONTS
  fonts.fontconfig.enable = true;
 
 services.picom.enable = true;
}

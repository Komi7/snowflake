{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    brave
    kitty
    thunar
    rustdesk-flutter
    mpv
    fastfetch
    git
    wget
    curl
    killall
    neovim
    cmake
    clang
    geany
    polkit_gnome
    wlogout
  ];

  system.stateVersion = "25.11";
}

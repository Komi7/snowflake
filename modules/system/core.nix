{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    brave
    firefox 
    kitty
    thunar
    rustdesk-flutter
    mpv
    fastfetch
    git
    wget
    curl
    p7zip
    killall
    neovim
    cmake
    clang
    geany
    polkit_gnome
    wlogout
    networkmanagerapplet # Provides nm-connection-editor
    gsimplecal #calendar
  ];

  system.stateVersion = "25.11";
}

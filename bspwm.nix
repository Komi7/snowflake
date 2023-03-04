#
#  Bspwm configuration
#

{ config, lib, pkgs, ... }:

# "${pkgs.xorg.xrandr}/bin/xrandr --mode 1920x1080 --pos 0x0 --rotate normal"
{
  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;

      layout = "us";                              # Keyboard layout & €-sign
   #   xkbOptions = "eurosign:e";
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
          scrollMethod = "twofinger";
          naturalScrolling = true;                # The correct way of scrolling
          accelProfile = "adaptive";              # Speed settings
          #accelSpeed = "-0.5";
          disableWhileTyping = true;
        };
      };
    #  modules = [ pkgs.xf86_input_wacom ];        # Both needed for wacom tablet usage
    #  wacom.enable = true;

      displayManager = {                          # Display Manager
        lightdm = {
         enable = true;                          # Wallpaper and GTK theme
          background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
          greeters = {
            gtk = {
              theme = {
                name = "Dracula";
                package = pkgs.dracula-theme;
              };
              cursorTheme = {
                name = "Dracula-cursors";
                package = pkgs.dracula-theme;
                size = 16;
              };
            };
          };
        };
        defaultSession = "none+bspwm";            # none+bspwm -> no real display manager
      };
      windowManager= {
        bspwm = {                                 # Window Manager
          enable = true;
        };
      };


      #Drivers for AMD GPU
      #videoDrivers = [                           # Video Settings
        #"amdgpu"
      #];

 #     displayManager.sessionCommands = monitor;

      #Desktop w/ AMD GPU
      #displayManager.sessionCommands = ''
        #!/bin/sh
        
        #SCREEN=$(${pkgs.xorg.xrandr}/bin/xrandr | grep " connected " | wc -l)
        #if [[ $SCREEN -eq 1 ]]; then
        #  ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --primary --mode 1920x1080 --rotate normal
        #elif [[ $SCREEN -eq 2 ]]; then
        #  ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --primary --mode 1920x1080 --rotate normal --output DisplayPort-1 --mode 1920x1080 --rotate normal --left-of HDMI-A-1
        #elif [[ $SCREEN -eq 3 ]]; then
        #  ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --primary --mode 1920x1080 --rotate normal --output DisplayPort-1 --mode 1920x1080 --rotate normal --left-of HDMI-A-1 --output HDMI-A-0 --mode 1280x1024 --rotate normal --right-of HDMI-A-1
        #fi
      #'';                                        # Settings for correct display configuration; This can also be done with setupCommands when X server start for smoother transition (if setup is static)
                                                  # Another option to research in future is arandr
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';                                         # Used so computer does not goes to sleep

      resolutions = [
        { x = 1920; y = 1080; }
     #   { x = 1600; y = 900; }
     #   { x = 3840; y = 2160; }
      ];
    };
  };
  services.picom.enable = true;
  programs.zsh.enable = true;    # Weirdly needs to be added to have default user on lightdm
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.starship.enable = true;
  # enable ff2mpv native meesaging hosts
  programs.firefox.nativeMessagingHosts.ff2mpv = true;
  environment.systemPackages = with pkgs; [       # Packages installed
    xclip
    xorg.xev
    xorg.xkill
    xorg.xrandr
    tldr
    bat
    mpv
    lxappearance
    pcmanfm
    udisks2
    gvfs
#bspwm Packages
    sxhkd
#polybar package
    yad
    polybar
#ARCHIVE
    zip
    unzip
    xarchiver
#TERMINAL
    alacritty
    xterm
    wezterm
#ZSH
    fnm
    zsh-syntax-highlighting
    lsd
    exa
    starship
#CODE
    neovim
    geany
    vscodium
    jetbrains.pycharm-community
#LAUNCHER
    rofi
#   wofi
#SHOUSUKE FVT
    obsidian
  ];

  xdg.portal = {                                  # Required for flatpak with window managers
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}

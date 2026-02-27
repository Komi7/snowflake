{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/core.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/steam.nix
    ../../modules/system/virt.nix
    ../../modules/system/fontconfig.nix
    ../../modules/system/thunar.nix
    ../../modules/system/neovim.nix
    
  ];

  networking.hostName = "KOMI";
  networking.networkmanager.enable = true;

  users.users.shousuke = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "audio" "storage" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  #service
  services.xserver.enable = true;
  security.polkit.enable = true;  # Enable the Polkit Service
  services.udisks2.enable = true;

nix = {
    settings = {
      auto-optimise-store = true;
      #Enable Cachix to avoid rebuilding dependencies
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1d";
    };
  };


   # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
    };

   powerManagement = {
  	enable = true;
	  cpuFreqGovernor = "schedutil";
  };
  
   xdg.portal = {
   enable = true;
   extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
   config.common.default = "*";
   };


  # Others services
	  services.udev.enable = true;
	  services.envfs.enable = true;
	  services.dbus.enable = true;
	  services.fstrim.enable = true;
      services.libinput.enable = true;
      services.rpcbind.enable = false;
      services.nfs.server.enable = false;
      services.openssh.enable = true;
      services.fwupd.enable = true;
      services.upower.enable = true;
      services.gnome.gnome-keyring.enable = true;

}

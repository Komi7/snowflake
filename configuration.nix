# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{config, pkgs, host, username, options, lib, inputs, system, hyprland, ...}:
#{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./Steam.nix
      ./pkgs.nix
      ./virt-manager.nix
      ./hyprland.nix
    ];

  # Bootloader.
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;

  
   boot = {
	  #loader
	  loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      loader.timeout = 1;
      #Kernel
	  kernelPackages = pkgs.linuxPackages_latest;  # Use latest kernel.
      kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog" 
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
 	  ];
    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    
    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };
    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
      };    
};
  networking.hostName = "KOMI"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  security.polkit.enable = true;  # Enable the Polkit Service
  services.udisks2.enable = true;  #If you are trying to mount drives via a file manager

  # Enable the KDE Plasma Desktop Environment.
 #services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  #autoLogin
  services.displayManager = {
    sddm.enable = true;
 #   autoLogin = {
 #     enable = true;
 #     user = "shousuke";
 #   };
 #   defaultSession = "hyprland";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true; 

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shousuke = {
    isNormalUser = true;
   # Set the default shell here
    shell = pkgs.zsh;
    description = "Shousuke Komi";
    extraGroups = [ "networkmanager" "wheel" "virt-manager" "video" "audio" "storage" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  
  # Enable zsh system-wide
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   curl
   git
   kitty
   ghostty
   nano
   polkit_gnome
   lf
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #Nvida Setting
  # Enable OpenGL
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
    extraPackages = with pkgs; [
	  libva-vdpau-driver
  	  libvdpau
  	  libvdpau-va-gl 
  	  nvidia-vaapi-driver
  	  vdpauinfo
	  libva
      libva-utils		
    	];
  };

  # Configure the NVIDIA driver
  hardware.nvidia = {
  modesetting.enable = true;
  open = true; # Use the open-source kernel module
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.latest;

 # prime = {
 #   offload = {
 #     enable = true;
 #     enableOffloadCmd = true;
 #   };
    # Use the Bus IDs you found earlier
#    intelBusId = "PCI:0:2:0";
#    nvidiaBusId = "PCI:1:0:0";
#   };
  };

  # Load the nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  # List services that you want to enable:
  
  #Enabling Flakes
  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  
  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
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


  # Others services
  	  services.gvfs.enable = true;
	  services.tumbler.enable = true;
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
      services.blueman.enable = true;
      
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}

{ config, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true; # Use false for older cards (pre-RTX 2000)
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}

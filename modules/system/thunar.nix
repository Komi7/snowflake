{ pkgs, ... }: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Services required for Thunar to work properly
  services.gvfs.enable = true; 
  services.tumbler.enable = true;
}

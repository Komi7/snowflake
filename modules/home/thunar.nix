{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpegthumbnailer
    evince
    thunar-dropbox-plugin
  ];

  # This is where your custom actions (Open Terminal Here) go
  xdg.configFile."Thunar/uca.xml".text = ''
    '';
  xdg.mimeApps = {
  enable = true;
  defaultApplications = {
    "inode/directory" = [ "thunar.desktop" ];
  };
};
}

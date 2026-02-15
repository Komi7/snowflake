{ pkgs, ... }: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    # This specifically manages the ~/.icons/default/index.theme file
    x11.defaultCursor = "catppuccin-mocha-mauve-cursors";
    
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
  };
}

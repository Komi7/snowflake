{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
	 monitor = [ "HDMI-A-1, 1920x1080@100, auto, 1" ];
	 # Environment Variables for NVIDIA/Wayland
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NIXOS_OZONE_WL,1"
      ];

      "$mod" = "SUPER";
      "$mod1" = "ALT";
      

      exec-once = [
   #     "hyprpaper"
   #    "swww-daemon"
        "dunst"
        "copyq --start-server"
        "${pkgs.swaybg}/bin/swaybg -i ~/Pictures/wallhaven-zy365v.jpg -m fill"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];

     bind = [
        # --- Essentials ---
        "$mod, X, exec, kitty"
        "$mod, F, exec, brave"
        "$mod1, E, exec, thunar"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, T, togglefloating,"
        "$mod, V, exec, copyq show"
        "$mod, P, pseudo," # dwindle
        "$mod, J, togglesplit," # dwindle
        "$mod, Space, exec, rofi -show drun"

        # --- Focus Movement ---
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        # Vim-style Focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # --- Window Movement (Swap) ---
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # --- Multimedia Keys (Function Keys) ---
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        
        # --- Screenshots (Requires grim and slurp) ---
    #    "$mod1, F12, exec, grim -g \"$(slurp)\" - | wl-copy"
    # Updated Screenshot Binding
        "$mod1, F12, exec, grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"
      ] ++ (
        # --- Workspace Bindings (1-10) ---
        # $mod + [1-0] to switch workspace
        # $mod + SHIFT + [1-0] to move window to workspace
        builtins.concatLists (builtins.genList (i:
          let
            ws = i + 1;
            key = if i == 9 then "0" else toString ws;
          in [
            "$mod, ${key}, workspace, ${toString ws}"
            "$mod SHIFT, ${key}, movetoworkspace, ${toString ws}"
          ]
        ) 10)
      );

      # --- Mouse Bindings (Resize/Move) ---
      bindm = [
        "$mod, mouse:272, movewindow"   # Left Click
        "$mod, mouse:273, resizewindow" # Right Click
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };
      

decoration = {
        rounding = 8;

        # Shadow settings moved here in recent updates
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
    
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      }; 
      
      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };
    };
  };
}  

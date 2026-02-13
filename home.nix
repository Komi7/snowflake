{ pkgs, ... }:

{
  home.username = "shousuke";
  home.homeDirectory = "/home/shousuke";
  home.stateVersion = "25.11"; 

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
	 monitor = [ "HDMI-A-1, preferred, auto, 1" ];
      "$mod" = "SUPER";
      "$mod1" = "ALT";
      

      exec-once = [
   #     "hyprpaper"
   #    "swww-daemon"
        "dunst"
        "${pkgs.swaybg}/bin/swaybg -i ~/Pictures/wallhaven-zy365v.jpg -m fill"
      ];

     bind = [
        # --- Essentials ---
        "$mod, X, exec, kitty"
        "$mod, F, exec, firefox"
        "$mod1, E, exec, dolphin"
        "$mod, R, exec, rofi -show drun"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo," # dwindle
        "$mod, J, togglesplit," # dwindle
        "$mod, Space, exec, pkill rofi || rofi -show drun"

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

programs.waybar = {
    enable = true;
    systemd.enable = true; # Helps with auto-starting and reliability
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "tray" ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };

        "clock" = {
          format = "{:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "pulseaudio" = {
    format = "{icon} {volume}% {format_source}";
    format-bluetooth = " {volume}% {format_source}";
    format-bluetooth-muted = " 󰝟 {format_source}";
    format-muted = "󰝟 {format_source}";
    format-source = " {volume}%";
    format-source-muted = "";
    format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
    };
    
    # --- The Control Logic ---
    on-click = "pavucontrol";          # Left click: Open full GUI mixer
    on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; # Right click: Mute
    on-scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"; # Scroll up: Volume +
    on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";      # Scroll down: Volume -
    
    # This allows you to switch between devices (Sinks) via the tooltip
    tooltip-format = "{desc} | {bus}";
};

        "network" = {
          format-wifi = " {essid}";
          format-ethernet = "󰈀 Wired";
          format-disconnected = "⚠ Disconnected";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: rgba(26, 27, 38, 0.8);
        border-bottom: 2px solid rgba(100, 114, 125, 0.3);
        color: #ffffff;
      }

      #workspaces button {
        padding: 0 5px;
        color: #7aa2f7;
      }

      #workspaces button.active {
        color: #bb9af7;
        border-bottom: 2px solid #bb9af7;
      }

      #clock, #pulseaudio, #network, #cpu, #memory, #tray {
        padding: 0 10px;
        color: #cfc9c2;
      }
      
      #pulseaudio {
    background-color: #f1fa8c; /* Dracula Yellow or adjust to your theme */
    color: #282a36;
    border-radius: 10px;
    margin: 4px;
    padding: 0 15px;
}

#pulseaudio.muted {
    background-color: #ff5555; /* Red when muted */
    color: #ffffff;
}
      
    '';
  };
  
#  services.hyprpaper = {
#    enable = true;
#    settings = {
#      ipc = "on";
#      splash = false;
#      # Replace the path below with your actual wallpaper image path
#      preload = [ "/home/shousuke/Pictures/wallhaven-zy365v.jpg" ];
#      wallpaper = [ "HDMI-A-1,/home/shousuke/Pictures/wallhaven-zy365v.jpg" ];
#    };
#  };

  # Packages for Shousuke
  home.packages = with pkgs; [
   #for hyprladn
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpicker
    rofi
 #   waybar
    swww
    dunst
    feh
    swaybg
    grim
    slurp
    wl-clipboard
    brightnessctl
 # Audio
    pavucontrol
    wireplumber
    #Fonts
    nerd-fonts.jetbrains-mono
  ];

  programs.home-manager.enable = true;
}

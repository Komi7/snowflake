{ pkgs, ... }:
{
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
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "tray" "custom/power" ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };
        
        "custom/power" = {
          format = "⏻";
          on-click = "wlogout"; # Launches the full-screen menu
          tooltip = false;
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
        background: rgba(30, 30, 46, 0.5); /* Transparent blur effect */
        color: #cdd6f4;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }

      #workspaces button {
        padding: 0 5px;
        color: #7aa2f7;
      }

      #workspaces button.active {
        background-color: #89b4fa;
        color: #11111b;
        border-radius: 5px;
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
}

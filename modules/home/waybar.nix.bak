{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top"; 
        position = "top";
        height = 34;
        margin-top = 8;
        margin-left = 10;
        margin-right = 10;
        spacing = 8;

        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "group/hardware" "pulseaudio" "network" "tray" "custom/power" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
          "1" = ""; # Terminal
          "2" = ""; # Browser
          "3" = ""; # Code
          "default" = "";
          };
        };

        "group/hardware" = {
          orientation = "horizontal";
          modules = [ "cpu" "memory" ];
        };

        "cpu" = {
          format = " {usage}%";
          interval = 10;
        };

        "memory" = {
          format = " {percentage}%";
          interval = 10;
        };

        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
          tooltip = false;
        };

        "clock" = {
        format = "{:%I:%M %p}";
        on-click = "gsimplecal"; # Opens a standalone calendar window
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        calendar = {
         mode          = "year";
         mode-mon-col  = 3;
         weeks-pos     = "right";
         on-scroll     = 1;
         format = {
            months =   "<span color='#ffead3'><b>{}</b></span>";
            days =     "<span color='#ecc6d9'><b>{}</b></span>";
            weeks =    "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today =    "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
       actions = {
        on-click-right = "mode";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
        };
       };
       
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        "network" = {
         format-wifi = " {essid}";
         format-ethernet = "󰈀 Wired";
         format-disconnected = "⚠ Disconnected";
         # Option A: Launch graphical editor (easiest)
         on-click = "nm-connection-editor";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Roboto", "Helvetica", sans-serif;
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.5);
        color: #cdd6f4;
      }

      #workspaces, #clock, #pulseaudio, #network, #cpu, #memory, #tray, #custom-power {
        background: rgba(45, 45, 70, 0.8);
        padding: 0 12px;
        margin: 4px 2px; 
        border-radius: 10px;
      }

      #workspaces button {
        padding: 0 5px;
        color: #7aa2f7;
      }

      #workspaces button.active {
        background-color: #89b4fa;
        color: #11111b;
        border-radius: 8px;
      }
      
      #network {
       background-color: rgba(45, 45, 70, 0.8); /* Matches your hardware/clock modules */
       color: #cfc9c2;
       border-radius: 10px;
       margin: 4px 2px;
       padding: 0 12px;
      }

      #custom-power {
        background-color: #ff5555;
        color: #ffffff;
      }
      
      #clock {  }

    tooltip {
     background: rgba(30, 30, 46, 0.9);
     border: 1px solid rgba(255, 255, 255, 0.1);
     border-radius: 10px;
     }

    tooltip label {
     color: #cdd6f4;
     }
    
      #pulseaudio.muted {
        background-color: #fab387;
        color: #11111b;
      }
    '';
  };
}

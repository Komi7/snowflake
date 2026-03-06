{ pkgs, ... }:
{
  # Adds playerctl so the media buttons work
  home.packages = [ pkgs.playerctl ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        margin-top = 10;
        margin-left = 15;
        margin-right = 15;
        spacing = 10;

        # Layout Logic
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" "mpris" ]; 
        modules-right = [ "group/hardware" "pulseaudio" "network" "tray" "custom/power" ];

        # Workspace Configuration
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "default" = "";
          };
        };

        # Interactive Media Controller (mpris)
        "mpris" = {
          format = "{player_icon} {title} | <span color='#89b4fa'>󰒮 󰐊 󰒭</span>";
          format-paused = "{player_icon} <i>{title}</i> | <span color='#f38ba8'>󰒮 󰐊 󰒭</span>";
          player-icons = {
            default = "󰎈";
            spotify = "";
            firefox = "";
          };
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl previous";
          max-length = 35;
        };

        # Full Interactive Calendar
        "clock" = {
          format = "{:%I:%M %p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
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

        # Hardware Monitoring Group
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

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = { default = ["" "" ""]; };
          on-click = "pavucontrol";
        };

        "network" = {
          format-wifi = " {essid}";
          format-ethernet = "󰈀 Wired";
          format-disconnected = "⚠ Disconnected";
        };

        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
        border: none;
      }

      window#waybar {
        background: transparent;
      }

      /* Unified Floating Island Styling */
      #workspaces, #clock, #mpris, #pulseaudio, #network, #cpu, #memory, #tray, #custom-power {
        background: rgba(17, 17, 27, 0.4);
        color: #cdd6f4;
        padding: 0 16px;
        margin: 0 4px;
        border-radius: 100px;
        transition: all 0.3s ease;
      }

      #workspaces button {
        color: #89b4fa;
        padding: 0 4px;
      }

      #workspaces button.active {
        color: #ffffff;
        background: rgba(137, 180, 250, 0.2);
        border-radius: 100px;
      }

      #workspaces button:hover {
        background: rgba(205, 214, 244, 0.1);
        border-radius: 100px;
      }

      #custom-power {
        background: rgba(243, 139, 168, 0.3);
        color: #f38ba8;
      }

      tooltip {
        background: rgba(30, 30, 46, 0.9);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 12px;
      }
    '';
  };
}

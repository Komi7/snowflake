{ pkgs, ... }:
{
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

        modules-left = [ "hyprland/workspaces" ]; 
        modules-center = [ "clock" ]; 
        modules-right = [ "group/hardware" "pulseaudio" "network" "tray" "custom/power" ];

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

        "group/hardware" = {
          orientation = "horizontal";
          modules = [ "cpu" "memory" ];
        };

        "cpu" = { format = " {usage}%"; interval = 10; };
        "memory" = { format = " {percentage}%"; interval = 10; };

        "clock" = {
          format = "{:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
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
        background: transparent; /* Essential for the island look */
      }

      /* Unified Floating Island Styling */
      #workspaces, #clock, #pulseaudio, #network, #cpu, #memory, #tray, #custom-power {
        background: rgba(17, 17, 27, 0.4); /* High transparency for frosted effect */
        color: #cdd6f4;
        padding: 0 16px;
        margin: 0 4px;
        border-radius: 100px; /* Maximum rounding for premium pill shapes */
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
        background: rgba(243, 139, 168, 0.3); /* Soft transparent red */
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

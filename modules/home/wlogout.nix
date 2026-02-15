{ pkgs, ... }:
{
 programs.wlogout = {
  enable = true;
  layout = [
    {
      label = "lock";
      action = "hyprlock";
      text = "Lock";
      keybind = "l";
    }
    {
      label = "reboot";
      action = "reboot";
      text = "Reboot";
      keybind = "r";
    }
    {
      label = "shutdown";
      action = "shutdown now";
      text = "Shutdown";
      keybind = "s";
    }
  ];
};
# Force overwrite the specific file causing the error
xdg.configFile."wlogout/layout".force = true;
}

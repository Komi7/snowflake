{ pkgs, ... }:
{
 virtualisation.libvirtd = {
  enable = true;
  qemu = {
    swtpm.enable = true;
    vhostUserPackages = with pkgs; [ virtiofsd ];
   # ovmf = {
    #  enable = true;
   #   package = pkgs.OVMFFull.override {
   #     secureBoot = true;
   #     tpmSupport = true;
   #   };
  #  };
  };
};
#virtualisation.libvirtd = {
#  enable = true;
#qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
#};
programs.virt-manager.enable = true;
 boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
};

users.users.shousuke.extraGroups = [ "libvirtd" ];
environment.systemPackages = with pkgs; [
  dnsmasq
  bridge-utils
  iptables
];

networking.firewall.trustedInterfaces = [ "virbr0" ];
services.qemuGuest.enable = true;
services.spice-vdagentd.enable = true;
}

{ config, lib, ... }:

let
  cfg = config.host.virtualization.guest.qemu;
in
with lib;
{
  options = {
    host.virtualization.guest.qemu.enable = mkEnableOption "virtualization.guest.qemu";
  };

  config = mkIf cfg.enable {
    services = {
      spice-vdagentd.enable = true; # enable copy and paste between host and guest
      qemuGuest.enable = true;
    };
  };
}

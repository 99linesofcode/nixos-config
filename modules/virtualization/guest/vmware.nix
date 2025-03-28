{ config, lib, ... }:

let
  cfg = config.host.virtualization.guest.vmware;
in
with lib;
{
  options = {
    host.virtualization.guest.vmware.enable = mkEnableOption "virtualization.guest.vmware";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "vmware" ];

    virtualisation.vmware.guest.enable = true;
  };
}

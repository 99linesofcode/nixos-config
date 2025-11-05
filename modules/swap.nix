{ config, lib, ... }:

let
  cfg = config.host.swap;
in
with lib;
{
  options.host.swap = {
    enable = mkEnableOption "swap partition";
  };

  config = mkIf cfg.enable {
    swapDevices = [
      {
        device = "/dev/nvme0n1p2";
      }
    ];

    boot.resumeDevice = "/dev/nvme0n1p2";
  };
}

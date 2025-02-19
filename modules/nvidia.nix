{
  config,
  lib,
  ...
}:
let
  cfg = config.host.nvidia;
in
with lib;
{
  options = {
    host.nvidia.enable = mkEnableOption "nvidia";
  };

  config = mkIf cfg.enable {
    boot.blacklistedKernelModules = [
      "nouveau"
    ];

    hardware = {
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta; # FIXME: see: https://github.com/NixOS/nixpkgs/issues/353990
        powerManagement = {
          enable = true;
          finegrained = true;
        };
        prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
          offload.enableOffloadCmd = true;
          reverseSync.enable = true;
        };
      };
    };

    services.xserver.videoDrivers = [
      "nvidia"
    ];
  };
}

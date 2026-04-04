{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.nvidia;
in
with lib;
{
  options.host.nvidia = {
    enable = mkEnableOption "nvidia";
  };

  config = mkIf cfg.enable {
    boot.blacklistedKernelModules = [
      "nouveau"
    ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
    };

    hardware = {
      graphics = {
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };

      nvidia = {
        modesetting.enable = true; # default since 535
        nvidiaSettings = true;
        open = false;
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
        powerManagement = {
          enable = true;
          finegrained = true;
        };
        prime = {
          intelBusId = "PCI:0:2:0"; # luna
          nvidiaBusId = "PCI:1:0:0"; # luna
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

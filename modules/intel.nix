{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.host.intel;
in
with lib;
{
  options = {
    host.intel.enable = mkEnableOption "intel";
  };

  # see: https://wiki.nixos.org/wiki/Intel_Graphics
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      intel-gpu-tools
    ];

    hardware = {
      cpu.intel.updateMicrocode = true;
      graphics = {
        extraPackages = with pkgs; [
          intel-compute-runtime # OpenCL for gen8 and beyond
          intel-media-sdk # Quick Sync Video for older processors
          intel-vaapi-driver # Accelerated Video Playback for older processors. LIBVA_DRIVER_NAME=i965
        ];
      };
    };

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}

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
      vpl-gpu-rt
      intel-gpu-tools
    ];

    hardware = {
      cpu.intel.updateMicrocode = true;
      graphics = {
        extraPackages = with pkgs; [
          intel-compute-runtime
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          intel-vaapi-driver # LIBVA_DRIVER_NAME=i965
          libvdpau-va-gl
        ];
      };
    };

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}

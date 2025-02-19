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

  config = mkIf cfg.enable {
    # TODO: extract top list to dedicated/generic graphics module
    environment.systemPackages = with pkgs; [
      # libva
      # libva-utils
      # vulkan-loader
      # vulkan-tools
      # vulkan-validation-layers
      vpl-gpu-rt
      intel-gpu-tools
    ];

    hardware = {
      cpu.intel.updateMicrocode = true;
      graphics = {
        enable = true;
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

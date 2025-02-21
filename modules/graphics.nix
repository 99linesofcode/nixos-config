{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.host.graphics;
in
with lib;
{

  options = {
    host.graphics.enable = mkEnableOption "graphics";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libva
      libva-utils
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}

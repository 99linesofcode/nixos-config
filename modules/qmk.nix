{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.qmk;
in
with lib;
{
  options = {
    host.qmk.enable = mkEnableOption "QMK";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      via
    ];

    services.udev.packages = [ pkgs.via ];

    hardware.keyboard.qmk.enable = true;
  };
}

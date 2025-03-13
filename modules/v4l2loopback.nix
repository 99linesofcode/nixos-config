{ config, lib, ... }:

let
  cfg = config.host.v4l2loopback;
in
with lib;
{
  options = {
    host.v4l2loopback.enable = mkEnableOption "v4l2loopback virtual video devices";
  };

  config = mkIf cfg.enable {
    boot = {
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="Virtual Camera" exclusive_caps=1
      '';
      kernelModules = [ "v4l2loopback" ];
    };
  };
}

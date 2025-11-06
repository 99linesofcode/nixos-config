{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.encryption;
in
with lib;
{
  options.host.encryption = {
    enable = mkEnableOption "LUKS filesystem encryption";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cryptsetup
    ];

    boot.initrd = {
      luks.devices = {
        "pool0_0" = {
          allowDiscards = true;
          bypassWorkqueues = true;
        };
      };
    };
  };
}

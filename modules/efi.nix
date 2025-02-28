{ config, lib, ... }:
let
  cfg = config.host.efi;
in
with lib;
{
  options = {
    host.efi.enable = mkEnableOption "booting via EFI";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = mkDefault false;
        systemd-boot = {
          enable = mkDefault true;
          configurationLimit = 16;
        };
      };
    };
  };
}

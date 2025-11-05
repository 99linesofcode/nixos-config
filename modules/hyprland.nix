{
  config,
  lib,
  ...
}:

let
  cfg = config.host.hyprland;
in
with lib;
{
  options.host.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = mkDefault true;
        withUWSM = mkDefault true;
      };
    };
  };
}

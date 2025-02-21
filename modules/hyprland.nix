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
  options = {
    host.hyprland.enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = mkDefault true;
      };
    };

    services = {
      dbus.packages = [ pkgs.gcr ]; # required for pinentry-gnome3 to work
      gnome.gnome-keyring.enable = true;
      udisks2.enable = true; # allow udiskie to query and manipulate storage devices
    };
  };
}

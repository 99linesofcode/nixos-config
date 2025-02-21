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
    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
    };

    programs = {
      hyprland = {
        enable = true;
        portalPackage = pkgs.xdg-desktop-portal-wlr;
      };
    };

    security = {
      pam = {
        services.gdm.enableGnomeKeyring = true;
      };
    };

    services = {
      dbus.packages = [ pkgs.gcr ]; # required for pinentry-gnome3 to work
      gnome.gnome-keyring.enable = true;
      udisks2.enable = true; # allow udiskie to query and manipulate storage devices
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common = {
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}

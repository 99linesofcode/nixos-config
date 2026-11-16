{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.wayland;
in
with lib;
{
  options.host.wayland = {
    enable = mkEnableOption "wayland window manager";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      GTK_USE_PORTAL = 1;
      NIXOS_OZONE_WL = 1;
    };

    security = {
      polkit.enable = mkDefault true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-termfilechooser
      ];
      xdgOpenUsePortal = true;
    };
  };
}

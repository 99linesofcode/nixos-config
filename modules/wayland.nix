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
  options = {
    host.wayland.enable = mkEnableOption "wayland window manager";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    security = {
      # TODO: determine whether and how I want to use keyring when setting up yubikey support
      # pam = {
      #   services.gdm.enableGnomeKeyring = mkDefault true;
      # };
      polkit.enable = mkDefault true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };
  };
}

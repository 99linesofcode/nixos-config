{
  config,
  lib,
  ...
}:
let
  cfg = config.host.docker;
in
with lib;
{
  options = {
    host.docker.enable = mkEnableOption "docker";
  };

  config = mkIf cfg.enable {
    environment = {
      #  TODO: docker should fallback to gnome-keyring by default
      # systemPackages = with pkgs; [
      #   docker-credential-helpers
      # ];
    };

    # TODO: generally not required, reflect on what to do with this
    hardware.nvidia-container-toolkit.enable = true;

    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      rootless.enable = true;
    };
  };
}

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

    hardware.nvidia-container-toolkit.enable = true;

    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      storageDriver = mkIf config.host.btrfs.enable "btrfs";
    };

    security.wrappers = {
      docker-rootlesskit = {
        owner = "root";
        group = "root";
        capabilities = "cap_net_bind_service+ep";
        source = "${pkgs.rootlesskit}/bin/rootlesskit";
      };
    };
  };
}

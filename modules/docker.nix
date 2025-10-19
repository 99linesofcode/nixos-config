{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.docker;
in
with lib;
{
  options.host.docker = with types; {
    enable = mkEnableOption "docker";
    rootless.enable = mkEnableOption "rootless mode";
  };

  config = mkIf cfg.enable {
    hardware.nvidia-container-toolkit.enable = mkIf config.host.nvidia.enable true;

    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      daemon.settings = mkIf (!config.host.docker.rootless.enable) {
        dns = config.networking.nameservers;
        log-driver = "json-file"; # fix kubernetes logging
      };
      rootless = mkIf config.host.docker.rootless.enable {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          dns = config.networking.nameservers;
          log-driver = "json-file"; # fix kubernetes logging
        };
      };
      storageDriver = mkIf config.host.btrfs.enable "btrfs";
    };

    networking = {
      firewall.allowedTCPPorts = [
        9003 # required so PHP XDebug can reach host machine
      ];
    };

    security.wrappers = mkIf config.host.docker.rootless.enable {
      docker-rootlesskit = {
        owner = "root";
        group = "root";
        capabilities = "cap_net_bind_service+ep";
        source = "${pkgs.rootlesskit}/bin/rootlesskit";
      };
    };
  };
}

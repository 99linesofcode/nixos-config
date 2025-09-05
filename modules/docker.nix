{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.docker;
  isNetworkd = config.host.networking.static.systemd-networkd.enable;
  networkdDns =
    config.systemd.network.networks."10-${config.host.networking.hostname}".networkConfig.DNS;
  networkManagerDns = config.networking.networkmanager.dns;
  dnsServers = if isNetworkd then networkdDns else networkManagerDns;
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
        dns = dnsServers;
        log-driver = "json-file"; # fix kubernetes logging
      };
      rootless = mkIf config.host.docker.rootless.enable {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          dns = dnsServers;
          log-driver = "json-file"; # fix kubernetes logging
        };
      };
      storageDriver = mkIf config.host.btrfs.enable "btrfs";
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

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
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "rclone/docker-volume-rclone:amd64"
      ];
      example = [
        "rclone/docker-volume-rclone:latest"
        "vieux/sshfs:latest"
      ];
      description = ''
        A list of Docker plugins to install automatically after Docker starts.
        Each item should be a valid plugin name or plugin reference usable with
        `docker plugin install`.
      '';
    };
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
      firewall = {
        trustedInterfaces = [ "br+" ]; # see: https://github.com/NixOS/nixpkgs/issues/417641#issuecomment-2984475281
        allowedTCPPorts = [
          9003 # required so PHP XDebug can reach host machine
        ];
      };
    };

    systemd.services = {
      install-docker-plugins = {
        description = "Install Docker plugins";
        documentation = [ "man:rclone(1)" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = false;
          ExecStart =
            pkgs.writeShellScript "install-docker-plugins" # bash
              ''
                #!/usr/bin/env sh

                docker="${pkgs.docker}/bin/docker"

                installedPlugins="$($docker plugin list --format '{{ .Name }}')"
                requiredPlugins="${builtins.concatStringsSep "\n" cfg.plugins}"

                printf '%s\n' "$installedPlugins" | grep -F -x -v "$requiredPlugins" | while IFS= read -r plugin; do
                  "$docker" plugin disable "$plugin"
                  "$docker" plugin rm "$plugin"
                  printf '%s\n' "Uninstalled $plugin"
                done >/dev/null

                printf '%s\n' "$requiredPlugins" | grep -F -x -v "$installedPlugins" | while IFS= read -r plugin; do
                  "$docker" plugin install --grant-all-permissions "$plugin"
                  printf '%s\n' "Installed $plugin"
                done >/dev/null
              '';
        };
      };
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

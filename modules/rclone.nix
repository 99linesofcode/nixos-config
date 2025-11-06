{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.rclone;
  dockerHasRclonePlugin = builtins.any (
    p: builtins.match ".*rclone.*" p != null
  ) config.host.docker.plugins;
in
with lib;
{
  options.host.rclone = {
    enable = mkEnableOption "rclone";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fuse
      rclone
    ];

    # TODO: encrypt to disk using rclone config encryption?
    sops.secrets = mkIf (config.host.docker.enable && dockerHasRclonePlugin) {
      "docker-rclone/rclone.conf" = {
        format = "binary";
        sopsFile = ../hosts/shared/secrets/rclone.conf;
      };
    };

    systemd.tmpfiles.rules =
      mkIf (config.host.docker.enable && !config.host.docker.rootless.enable && dockerHasRclonePlugin)
        [
          "d /var/lib/docker-plugins/rclone/config 0755 root root -"
          "d /var/lib/docker-plugins/rclone/cache  0755 root root -"
        ];

    # NOTE: sops symlinks to /run/secrets and Docker doesn't follow symlinks so we need to copy the file instead
    systemd.services = mkIf (config.host.docker.enable && dockerHasRclonePlugin) {
      copy-docker-rclone-config = {
        description = "Copy rclone.conf to docker-plugins directory";
        documentation = [ "man:rclone(1)" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = false;
          ExecStart =
            pkgs.writeShellScript "copy-docker-rclone-config" # sh
              ''
                #!/usr/bin/env sh

                filepath="${config.sops.secrets."docker-rclone/rclone.conf".path}"

                cp "$filepath" /var/lib/docker-plugins/rclone/config/rclone.conf
                chmod 600 /var/lib/docker-plugins/rclone/config/rclone.conf
              '';
        };
      };
    };
  };
}

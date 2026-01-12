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
    sops.secrets = {
      "rclone/rclone.conf" = {
        format = "binary";
        sopsFile = "${config.host.root}/hosts/shared/secrets/rclone.conf";
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

                srcPath="${config.sops.secrets."rclone/rclone.conf".path}"
                destPath="/var/lib/docker-plugins/rclone/config/rclone.conf"

                cp "$srcPath" "$destPath"
                chmod 600 "$destPath"
              '';
        };
      };
    };
  };
}

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
  options = {
    host.rclone.enable = mkEnableOption "rclone";
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
        path = "/var/lib/docker-plugins/rclone/config/rclone.conf";
      };
    };

    systemd.tmpfiles.rules =
      mkIf (config.host.docker.enable && config.host.docker.rootless.enable && dockerHasRclonePlugin)
        [
          "d /var/lib/docker-plugins/rclone/config 0755 root root -"
          "d /var/lib/docker-plugins/rclone/cache  0755 root root -"
        ];
  };
}

{ config, lib, ... }:

let
  cfg = config.host.btrfs;
in
with lib;
{
  options = {
    host.btrfs.enable = mkEnableOption "BTRFS partitioning";
  };

  config = mkIf cfg.enable {
    boot = {
      supportedFilesystems = [
        "btrfs"
        "vfat"
      ];
    };

    fileSystems = {
      "/".options = [
        "subvol=root"
        "compress=zstd"
        "noatime"
      ];
      "/home".options = [
        "subvol=home"
        "compress=zstd"
        "noatime"
      ];
      "/nix".options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
      "/var/log" = {
        options = [
          "subvol=log"
          "compress=zstd"
          "noatime"
        ];
        neededForBoot = true;
      };
    };
  };
}

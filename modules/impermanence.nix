{ config, lib, ... }:

let
  cfg = config.host.impermanence;
in
with lib;
{
  options.host.impermanence = {
    enable = mkEnableOption "impermanence";
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "folders that should be stored in /persist";
    };
  };

  config = mkIf cfg.enable {
    environment.persistence."/persist" = {
      directories = [
        "/root"
        "/var/lib/nixos"
      ]
      ++ config.host.impermanence.directories;
      hideMounts = true;
    };

    boot.initrd.systemd = {
      services.rollback = {
        description = "Rollback BTRFS root subvolume to a pristine state";
        wantedBy = [ "initrd.target" ];
        after = [ "systemd-cryptsetup@pool0_0.service" ];
        before = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = # sh
          ''
            mkdir -p /mnt
            mount -o subvol=/ /dev/mapper/pool0_0 /mnt

            btrfs subvolume list -o /mnt/root | cut -f9 -d ' ' | while read subvolume; do
              echo "deleting /$subvolume subvolume..."
              btrfs subvolume delete "/mnt/$subvolume"
            done

            echo "deleting /root subvolume..."
            btrfs subvolume delete /mnt/root

            echo "restoring blank /root subvolume..."
            btrfs subvolume snapshot /mnt/root-blank /mnt/root

            umount /mnt
          '';
      };
    };
  };
}

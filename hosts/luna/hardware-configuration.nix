{ modulesPath, pkgs, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ "dm-snapshot" ];
      luks.devices."cryptlvm" = {
        allowDiscards = true;
        bypassWorkqueues = true;
        device = "/dev/disk/by-uuid/6c47b269-ae73-4fa6-a7cc-808faff74f0f";
      };
      systemd.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [
      "vfat"
      "btrfs"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e9f4f91f-6aff-449d-93d1-b2fa78edd69c";
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress=zstd"
        "noatime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/7A69-A19B";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/e9f4f91f-6aff-449d-93d1-b2fa78edd69c";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/e9f4f91f-6aff-449d-93d1-b2fa78edd69c";
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
        "noatime"
      ];
    };
    "/persist" = {
      device = "/dev/disk/by-uuid/e9f4f91f-6aff-449d-93d1-b2fa78edd69c";
      fsType = "btrfs";
      options = [
        "subvol=persist"
        "compress=zstd"
        "noatime"
      ];
    };
    "/log" = {
      device = "/dev/disk/by-uuid/e9f4f91f-6aff-449d-93d1-b2fa78edd69c";
      fsType = "btrfs";
      options = [
        "subvol=log"
        "compress=zstd"
        "noatime"
      ];
    };
  };

  hardware = {
    openrazer = {
      enable = true;
      users = [ "shorty" ];
    };
  };

  services = {
    undervolt = {
      enable = true;
      coreOffset = -125;
      gpuOffset = -925;
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/809674e5-ddd6-45b8-a318-4c3dbb431eb5"; }
  ];
}

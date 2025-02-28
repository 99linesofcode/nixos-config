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
}

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
    };
    kernelPackages = pkgs.linuxPackages_zen;
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

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

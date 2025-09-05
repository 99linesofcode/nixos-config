{
  inputs,
  modulesPath,
  pkgs,
  self,
  ...
}:

let
  username = "shorty";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disko.nix
    ./hardware-configuration.nix
    ../shared
  ];

  boot.kernelParams = [
    "mds=full,nosmt" # see: https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html
    "mmio_stale_data=full,nosmt" # see: https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html
  ];

  environment.systemPackages = with pkgs; [
    busybox
    git
    zsh
  ];

  hardware = {
    openrazer = {
      enable = true;
      users = [ "${username}" ];
    };
  };

  host = {
    root = self.outPath;
    user.${username}.enable = true;

    efi.enable = true;
    encryption.enable = true;
    btrfs.enable = true;
    swap.enable = true;

    networking = {
      hostname = "luna";
      static = {
        systemd-networkd.enable = true;
      };
    };
    printing.enable = true;
    virtualization.enable = true;

    avahi.enable = true;
    bluetooth.enable = true;
    catt.enable = true;
    docker = {
      enable = true;
      rootless.enable = false;
    };
    graphics.enable = true;
    hyprland.enable = true;
    intel.enable = true;
    k3s.enable = true;
    nvidia.enable = true;
    power-management.enable = true;
    sound.enable = true;

    openssh.enable = true;
    qmk.enable = true;
    steam.enable = true;
    v4l2loopback.enable = true;
    wayland.enable = true;
    # yubikey.enable = true;
  };

  programs = {
    localsend.enable = true;
  };

  services = {
    getty.autologinUser = "${username}"; # hardcoded because this is a single user system
    udisks2.enable = true;
    undervolt = {
      enable = true;
      coreOffset = -125;
      gpuOffset = -925;
    };
  };
}

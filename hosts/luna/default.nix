{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

let
  username = "shorty";
in
with lib;
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
    rustdesk
  ];

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production; # NOTE: support for this GPU is dropped after driver version 580 (and there is no dedicated legacy package for it as of yet)
    };
    openrazer = {
      enable = true;
      users = [ "${username}" ];
    };
  };

  host = {
    user.${username}.enable = true;

    efi.enable = true;
    encryption.enable = true;
    btrfs.enable = true;
    impermanence.enable = true;
    swap.enable = true;

    network = {
      hostname = "luna";
      manager.enable = true;
      systemd-resolved.enable = true;
    };

    printing.enable = true;
    virtualization.enable = true;

    bluetooth.enable = true;
    catt.enable = true;
    docker = {
      enable = true;
      rootless.enable = false;
    };
    graphics.enable = true;
    hyprland.enable = true;
    intel.enable = true;
    # k3s.enable = true;
    nvidia.enable = true;
    power-management.enable = true;
    rclone.enable = true;
    sound.enable = true;
    sunshine.enable = true;
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
    # TODO: extract automatic timezoned and geolocate to module for portable devices?
    automatic-timezoned.enable = true;
    geoclue2 = {
      enableDemoAgent = mkForce true; # FIXME: see https://github.com/NixOS/nixpkgs/issues/68489#issuecomment-1484030107
      geoProviderUrl = "https://beacondb.net/v1/geolocate";
    };
    getty.autologinUser = "${username}"; # hardcoded because this is a single user system
    pipewire.wireplumber.extraConfig."luna-20" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "device.name" = "alsa_input.pci-0000_00_1f.3.analog-stereo";
            }
          ];
          actions = {
            update-props = {
              "node.volume" = 0.1;
            };
          };
        }
      ];
    };
    udisks2.enable = true;
    undervolt = {
      enable = true;
      coreOffset = -125;
      gpuOffset = -925;
    };
  };
}

{
  modulesPath,
  pkgs,
  ...
}:

let
  username = "shorty";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
    ./hardware-configuration.nix
    ../shared
  ];

  environment.systemPackages = with pkgs; [
    busybox
    gitMinimal
    pass
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  host = {
    user.${username}.enable = true;

    network = {
      hostname = "mars";
    };

    docker = {
      enable = true;
      rootless.enable = false;
    };
    k3s.enable = true;
    openssh.enable = true;
    rclone.enable = true;
    restic.enable = true;
  };

  services = {
    restic.paths = [
      "/home/shorty/.config/server01/"
      "/home/shorty/.config/piratenportaal/"
      "/var/lib/docker/volumes"
    ];
  };
}

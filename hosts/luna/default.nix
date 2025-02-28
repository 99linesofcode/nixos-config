{
  inputs,
  pkgs,
  ...
}:
let
  username = "shorty";
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
    ../shared
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
    user.${username}.enable = true;

    efi.enable = true;
    encryption.enable = true;
    btrfs.enable = true;

    bluetooth.enable = true;
    docker.enable = true;
    graphics.enable = true;
    hyprland.enable = true;
    intel.enable = true;
    nvidia.enable = true;
    power-management.enable = true;
    sound.enable = true;
    openssh.enable = true;
    steam.enable = true;
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

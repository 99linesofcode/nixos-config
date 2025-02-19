{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../shared
  ];

  environment.systemPackages = with pkgs; [
    busybox
    cryptsetup
    git
    zsh
  ];

  host = {
    user.shorty.enable = true;

    bluetooth.enable = true;
    docker.enable = true;
    hyprland.enable = true;
    intel.enable = true;
    nvidia.enable = true;
    power-management.enable = true;
    sound.enable = true;
    openssh.enable = true;
    steam.enable = true;
    # yubikey.enable = true;
  };

  programs = {
    localsend.enable = true;
  };

  services = {
    automatic-timezoned.enable = true;
    geoclue2.geoProviderUrl = "https://beacondb.net/v1/geolocate";
  };
}

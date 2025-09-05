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
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
    ./hardware-configuration.nix
    ../shared
  ];

  environment.systemPackages = with pkgs; [
    busybox
    gitMinimal
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  host = {
    root = self.outPath;
    user.${username}.enable = true;

    docker = {
      enable = true;
      rootless.enable = false;
    };
    k3s.enable = true;

    openssh.enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.shorty.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqG66VN/cnEOLtpCb9yt8O2WIk4CvVwRdAweBdD10mG shorty@luna"
  ];
}

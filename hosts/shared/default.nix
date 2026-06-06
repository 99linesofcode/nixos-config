{ config, lib, ... }:

with lib;
{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
  ];

  host = {
    sops.enable = true;
  };

  boot = {
    initrd = {
      systemd.enable = true;
    };
  };

  networking.hostName = config.host.network.hostname;

  programs = {
    dconf.enable = true;
  };

  services = {
    keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          capslock = "escape";
          escape = "capslock";
        };
      };
    };
  };
}

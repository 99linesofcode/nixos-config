{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.sops;
in
with lib;
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options = {
    host.sops.enable = mkEnableOption "sops";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age
      ssh-to-age
      sops
    ];

    sops = {
      defaultSopsFile = ../.sops.yaml;
      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };
    };
  };
}

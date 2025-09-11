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
  };
}

{
  config,
  lib,
  ...
}:

let
  cfg = config.host.steam;
in
with lib;
{
  options = {
    host.steam.enable = mkEnableOption "steam";
  };

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        dedicatedServer.openFirewall = false;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
      };
    };
  };
}

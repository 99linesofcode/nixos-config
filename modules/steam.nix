{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.steam;
in
with lib;
{
  options.host.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf cfg.enable {
    programs = {
      gamescope = {
        enable = true;
      };
      steam = {
        enable = true;
        package = pkgs.steam.override {
          extraPkgs =
            pkgs': with pkgs'; [
              libXcursor
              libXi
              libXinerama
              libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib # Provides libstdc++.so.6
              libkrb5
              keyutils
            ];
        };
        dedicatedServer.openFirewall = false;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
      };
    };
  };
}

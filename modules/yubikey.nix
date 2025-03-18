{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.yubikey;
in
with lib;
{
  options = {
    host.yubikey.enable = mkEnableOption "yubikey";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      yubikey-personalization
      yubico-piv-tool
      yubioath-flutter
    ];

    security = {
      pam = {
        # TODO: determine whether to enable or put behind enable flag
        # sshAgentAuth.enable = true; # enable authenticating using SSH key instead of passwords
        services = {
          login.u2fAuth = true;
          sudo.u2fAuth = true;
        };
      };
    };

    services = {
      pcscd.enable = true;
      udev = {
        extraRules = ''
          ACTION=="remove",\
           ENV{ID_BUS}=="usb",\
           ENV{ID_MODEL_ID}=="0407",\
           ENV{ID_VENDOR_ID}=="1050",\
           ENV{ID_VENDOR}=="Yubico",\
           RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
        '';
        packages = [ pkgs.yubikey-personalization ];
      };
    };

    programs = {
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}

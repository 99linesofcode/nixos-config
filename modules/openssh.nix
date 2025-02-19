{
  config,
  lib,
  ...
}:
let
  cfg = config.host.openssh;
in
with lib;
{
  options = {
    host.openssh.enable = mkEnableOption "openssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      hostKeys = [
        # TODO: impermanence baby
        # {
        #   path = "/persist/etc/ssh/ssh_host_ed25519_key";
        #   type = "ed25519";
        # }
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
      settings = {
        MaxAuthTries = mkDefault 3;
        PermitRootLogin = mkDefault "no";
      };
    };
  };
}

{
  config,
  lib,
  ...
}:

let
  cfg = config.host.openssh;
  userDirectoryFiles = builtins.readDir (config.host.root + "/users");
  userDirectories = lib.attrsets.filterAttrs (_name: type: type == "directory") userDirectoryFiles;
  users = builtins.attrNames userDirectories;
in
with lib;
{
  options.host.openssh = {
    enable = mkEnableOption "openssh";
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
        AllowUsers = users;
        KbdInteractiveAuthentication = mkDefault false;
        MaxAuthTries = mkDefault 3;
        PermitRootLogin = mkDefault "no";
        PasswordAuthentication = mkDefault false;
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.user.shorty;
  ifTheyExist = c: builtins.filter (group: builtins.hasAttr group config.users.groups) c;
in
with lib;
{
  options = {
    host.user.shorty.enable = mkEnableOption "user shorty";
  };

  config = mkIf cfg.enable {
    sops.secrets.shorty-password = {
      format = "binary";
      sopsFile = "${config.host.root}/users/shorty/secrets/passwd";
      neededForUsers = true;
    };

    users.users.shorty = {
      isNormalUser = true;
      uid = 1000;
      group = "users";
      description = "Jordy Schreuders";
      shell = pkgs.zsh;
      extraGroups =
        [
          "wheel"
        ]
        ++ ifTheyExist [
          "libvirtd"
          "networkmanager"
          "openrazer"
        ];
      hashedPasswordFile = config.sops.secrets.shorty-password.path;
    };

    programs.zsh.enable = true; # required in order to set user shell
  };
}

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
      extraGroups = [
        "wheel"
      ]
      ++ ifTheyExist [
        "docker"
        "libvirtd"
        "networkmanager"
        "openrazer"
      ];
      hashedPasswordFile = config.sops.secrets.shorty-password.path;
      # TODO: make configurable and maybe read from private repo even though these are public
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqG66VN/cnEOLtpCb9yt8O2WIk4CvVwRdAweBdD10mG shorty@luna"
      ];
    };

    programs.zsh.enable = true; # required in order to set user shell
  };
}

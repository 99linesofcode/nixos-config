{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.user.shorty;
  username = "shorty";
  hostname = config.host.network.hostname;
  ifTheyExist = c: builtins.filter (group: builtins.hasAttr group config.users.groups) c;
in
with lib;
{
  options.host.user.${username} = {
    enable = mkEnableOption "user ${username}";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      shorty-password = {
        format = "binary";
        sopsFile = "${config.host.root}/hosts/${hostname}/users/${username}/secrets/passwd";
        neededForUsers = true;
      };
      "ssh/id_ed25519" = {
        format = "binary";
        sopsFile = "${config.host.root}/hosts/${hostname}/users/${username}/secrets/id_ed25519";
        owner = username;
        path = "/home/${username}/.ssh/id_ed25519";
        mode = "600";
      };
      "ssh/id_ed25519.pub" = {
        format = "binary";
        sopsFile = "${config.host.root}/hosts/${hostname}/users/${username}/secrets/id_ed25519.pub";
        owner = username;
        path = "/home/${username}/.ssh/id_ed25519.pub";
        mode = "600";
      };
    };

    users.users.${username} = {
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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0KFX+0kp0mrYIo8F+Jq/7T09R3bigfZC5GEWkIl+J5 shorty@luna"
      ];
    };

    programs.zsh = {
      enable = true; # required in order to set user shell
    };
  };
}

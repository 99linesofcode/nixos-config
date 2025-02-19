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
      sopsFile = mkDefault ./secrets/passwd;
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
          "docker"
          "libvirtd"
          "openrazer"
        ];

      hashedPasswordFile = config.sops.secrets.shorty-password.path;
    };

    programs.zsh.enable = true; # required in order to set user shell

    # swap ESC and CAPSLOCK in console and beyond
    console.useXkbConfig = true;
    services = {
      xserver.xkb.options = "caps:swapescape";
    };
  };
}

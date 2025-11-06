{ lib, self, ... }:

let
  files = lib.filesystem.listFilesRecursive ./.;
  moduleFilePaths = builtins.filter (f: !lib.hasInfix "default.nix" f && lib.hasSuffix "nix" f) files;
in
with lib;
{
  imports = moduleFilePaths;

  options.host = {
    root = mkOption {
      type = types.path;
      description = "nix store path declaration";
    };
  };

  config = {
    host = {
      root = self.outPath;
    };

    boot = {
      initrd = {
        systemd.enable = true;
      };
    };
  };
}

{ lib, ... }:
let
  files = lib.filesystem.listFilesRecursive ./.;
  moduleFilePaths = builtins.filter (f: !lib.hasInfix "default.nix" f && lib.hasSuffix "nix" f) files;
in
{
  imports = moduleFilePaths;
}

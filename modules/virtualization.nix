{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.virtualization;
in
with lib;
{
  options = {
    host.virtualization.enable = mkEnableOption "virtualization";
  };

  config = mkIf cfg.enable {
    programs = {
      dconf.enable = true;
      virt-manager.enable = true;
    };

    virtualisation = {
      libvirtd = {
        enable = true;

        # TMP emulation
        qemu = {
          swtpm.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
      # useBootLoader = true;
      # useEFIBoot = true;
      # useSecureBoot = true;
    };
  };
}

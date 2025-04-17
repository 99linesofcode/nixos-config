{ ... }:

{
  boot.kernel.sysctl = {
    "kernel.sysrq" = 0; # disable magic sysrq key
  };

  security = {
    # apparmor = {
    #   enable = true;
    #   killUnconfinedConfinables = true;
    #   packages = [pkgs.apparmor-profiles];
    # };

    # force-enable the Page Table Isolation (PTI) Linux kernel feature
    # forcePageTableIsolation = true;

    # prevent replacing the running kernel image.
    # protectKernelImage = true;

    sudo = {
      enable = true;
      wheelNeedsPassword = false;
      execWheelOnly = true;
    };

    #  flushes L1 data cache every time the hypervisor enters the guest.
    # virtualization.flushL1DataCache = "always";
  };
}

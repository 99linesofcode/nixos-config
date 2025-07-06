{ ... }:

{
  nix = {
    gc = {
      automatic = true;
      dates = "19:00";
      persistent = true;
      options = "--delete-older-than 14d";
    };
    settings = {
      accept-flake-config = true;
      auto-optimise-store = true;
      download-buffer-size = 524288000; # 500MB
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      log-lines = 30;
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  nixpkgs = {
    config = {
      allowBroken = false;
      allowUnfree = true;
    };
  };

  system = {
    stateVersion = "25.05";
  };
}

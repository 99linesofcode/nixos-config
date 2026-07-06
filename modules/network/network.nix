{
  lib,
  ...
}:

with lib;
{
  options.host.network = with types; {
    nameservers = mkOption {
      type = listOf str;
      default = [
        "9.9.9.9"
        "149.112.112.112"
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
    };
  };
}

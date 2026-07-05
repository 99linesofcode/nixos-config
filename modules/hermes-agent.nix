{
  config,
  inputs,
  lib,
  ...
}:

let
  cfg = config.host.hermes-agent;
in
with lib;
{
  imports = [
    inputs.hermes-agent.nixosModules.default
  ];

  options.host.hermes-agent = {
    enable = mkEnableOption "Self-improving AI agent with a built-in learning loop";
  };

  config = mkIf cfg.enable {
    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;
      environmentFiles = [ config.sops.secrets."hermes-env".path ];
      extraDependencyGroups = [
        "messaging"
      ];
      settings = {
        model.default = "z-ai/glm-5.2";
      };
    };
  };
}

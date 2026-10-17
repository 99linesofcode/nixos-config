{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.k3s;
in
with lib;
{
  options.host.k3s = {
    enable = mkEnableOption "k3s - lightweight Kubernetes distribution";

    nodeExternalIP = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        External IP address advertised by the k3s node. Set to null to let
        k3s use the node's internal IP without a separate external IP.
      '';
    };

    loopbackAddress = mkOption {
      type = types.nullOr types.str;
      default = "10.0.0.1";
      description = ''
        Address to add to the loopback interface as a /32 (the workstation's
        `*.test` loopback trick). Set to null to leave `lo` untouched.
      '';
    };

    docker = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether k3s uses the Docker runtime (`--docker`) instead of containerd.
        Disable when the host runs its own Docker daemon.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        go-task # task runner alternative to Make
        kubernetes-helm
      ];

      etc."kube/config" = {
        source = "/var/lib/rancher/k3s/server/cred/admin.kubeconfig";
        target = "/home/shorty/.kube/config";
        mode = "0600";
        user = "shorty";
        group = "users";
      };

      variables = {
        KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
      };
    };

    services.k3s = {
      enable = true;
      extraFlags = [
        "--disable=traefik"
        # "--disable=servicelb" # TODO: disable later on when we switch to MetalLB
      ]
      ++ optional cfg.docker "--docker"
      ++ [
        "--write-kubeconfig-mode=0644"
      ];
      nodeExternalIP = cfg.nodeExternalIP;
      role = "server";
      # autoDeployCharts = {
      #   traefik = {
      #     name = "traefik";
      #     repo = "https://traefik.github.io/charts";
      #     version = "36.1.0";
      #     hash = "sha256-APQuQjKEpNwIaNi0RujZS1RcVLuPKC2PEXNLeM8/1F0=";
      #     values = {
      #       providers = {
      #         kubernetesIngress.enabled = false;
      #         kubernetesGateway.enabled = true;
      #       };
      #       gateway.namespacePolicy = "All";
      #     };
      #   };
      # };
    };

    networking = {
      firewall.allowedTCPPorts = [
        6443 # required so pods can reach API server
      ];
      interfaces.lo.ipv4.addresses = optional (cfg.loopbackAddress != null) {
        address = cfg.loopbackAddress;
        prefixLength = 32;
      };
    };
  };
}

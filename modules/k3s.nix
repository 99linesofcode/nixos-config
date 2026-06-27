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
        "--docker"
        "--write-kubeconfig-mode=0644"
      ];
      nodeExternalIP = "10.0.0.1";
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
      interfaces.lo.ipv4.addresses = [
        {
          address = "10.0.0.1";
          prefixLength = 32;
        }
      ];
    };
  };
}

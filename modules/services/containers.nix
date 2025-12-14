{ lib, ... }:

let
  ipv4Subnet = "10.97.0.0/24";
  ipv4Gateway = "10.97.0.1";
  ipv6Subnet = "fd97:fa1c:56ac::/64";
  ipv6Gateway = "fd97:fa1c:56ac::1";

  dockerIpv4Subnet = "10.96.0.0/24";
  dockerIpv4Gateway = "10.96.0.1";
  dockerIpv6Subnet = "fd97:fa1c:56ad::/64";
in
{
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings = {
        name = "podman";
        driver = "bridge";
        dns_enabled = true;
        ipv6_enabled = true;
        network_interface = "podman0";
        subnets = [
          {
            subnet = ipv4Subnet;
            gateway = ipv4Gateway;
          }
          {
            subnet = ipv6Subnet;
            gateway = ipv6Gateway;
          }
        ];
      };
    };

    docker = {
      enable = true;
      enableOnBoot = false;
      daemon.settings = {
        bip = "${dockerIpv4Gateway}/24";
        "fixed-cidr" = dockerIpv4Subnet;
        ipv6 = true;
        "fixed-cidr-v6" = dockerIpv6Subnet;
        "ip6tables" = true;
      };
    };

    oci-containers.backend = "podman";
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = lib.mkDefault 1;
    "net.ipv6.conf.all.forwarding" = lib.mkDefault 1;
    "net.ipv6.conf.default.forwarding" = lib.mkDefault 1;
  };
}

{
  lib,
  pkgs,
  config,
  ...
}:

{
  networking = {
    useDHCP = false;
    networkmanager.enable = false;
    useNetworkd = true;
    wireless.iwd = {
      enable = true;
      settings = {
        Settings.AutoConnect = true;
        General.EnableNetworkConfiguration = false;
      };
    };
    nftables.enable = true;
    firewall = {
      backend = "nftables";
      trustedInterfaces = [
        "podman+"
        "docker0"
        "tailscale0"
      ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  services.ntpd-rs.enable = true;
  services.timesyncd.enable = false;

  # Set regulatory domain for WiFi (Canada)
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom=CA
  '';

  systemd.network = {
    enable = true;
    netdevs."30-br0" = {
      netdevConfig = {
        Kind = "bridge";
        Name = "br0";
      };
    };
    networks."10-ethernet" = {
      matchConfig.Name = "e*";
      networkConfig = {
        Bridge = "br0";
        DHCP = "no";
        IPv6AcceptRA = false;
      };
      linkConfig.RequiredForOnline = "enslaved";
    };
    networks."35-br0" = {
      matchConfig.Name = "br0";
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
        IPv6PrivacyExtensions = false;
        MulticastDNS = true;
      };
      dhcpV4Config.RouteMetric = 100; # Prefer bridged Ethernet
      dhcpV6Config.RouteMetric = 100;
      linkConfig.RequiredForOnline = "routable";
    };
    networks."20-wireless" = {
      matchConfig.Name = "wl*";
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
        IPv6PrivacyExtensions = false;
        MulticastDNS = true;
      };
      dhcpV4Config.RouteMetric = 600;
      dhcpV6Config.RouteMetric = 600;
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
    fallbackDns = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
  };

  environment.systemPackages = [ pkgs.tailscale ];

  services.tailscale.enable = true;

  # Optimize network services for faster boot
  systemd.services = {
    # Start avahi on-demand via socket activation
    avahi-daemon.wantedBy = lib.mkForce [ ];
  };

  # Enable socket activation for avahi
  systemd.sockets.avahi-daemon = {
    wantedBy = [ "sockets.target" ];
  };
}

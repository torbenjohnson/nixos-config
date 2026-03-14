{
  lib,
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
        DHCP = false;
        IPv6AcceptRA = false;
      };
      linkConfig.RequiredForOnline = "enslaved";
    };
    networks."35-br0" = {
      matchConfig.Name = "br0";
      networkConfig = {
        DHCP = true;
        IPv6AcceptRA = true;
        IPv6PrivacyExtensions = false;
        MulticastDNS = false;
        KeepConfiguration = "dynamic";
      };
      dhcpV4Config.RouteMetric = 100; # Prefer bridged Ethernet
      dhcpV6Config.RouteMetric = 100;
      linkConfig.RequiredForOnline = "routable";
    };
    networks."20-wireless" = {
      matchConfig.Name = "wl*";
      networkConfig = {
        DHCP = true;
        IPv6AcceptRA = true;
        IPv6PrivacyExtensions = false;
        MulticastDNS = false;
        KeepConfiguration = "dynamic";
      };
      dhcpV4Config.RouteMetric = 600;
      dhcpV6Config.RouteMetric = 600;
      # WiFi is a fallback link — don't block network-online.target waiting for it
      linkConfig.RequiredForOnline = false;
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      Cache = true;
      FallbackDNS = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
  };

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

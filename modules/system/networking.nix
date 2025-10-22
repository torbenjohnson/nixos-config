{ ... }:

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
  };

  # Set regulatory domain for WiFi (Canada)
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom=CA
  '';

  systemd.network = {
    enable = true;
    networks = {
      "10-ethernet" = {
        matchConfig.Name = "e*";
        networkConfig = {
          DHCP = "yes";
          IPv6AcceptRA = true;
          IPv6PrivacyExtensions = false;
          MulticastDNS = true;
        };
        dhcpV4Config.RouteMetric = 100; # Prefer Ethernet
        dhcpV6Config.RouteMetric = 100;
      };
      "20-wireless" = {
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
  };

  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    fallbackDns = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    extraConfig = ''
      MulticastDNS=yes
      LLMNR=yes
    '';
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
  };
}

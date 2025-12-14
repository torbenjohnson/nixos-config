{ pkgs, lib, ... }:

{
  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;
  services.userborn.enable = true;
  systemd.sysusers.enable = false;
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "udev.log_level=3"
    ];
    consoleLogLevel = 3;

    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      systemd.enable = true;
      compressor = "zstd";
      compressorArgs = [
        "-19"
        "-T0"
      ];
      includeDefaultModules = false;
      systemd.emergencyAccess = true;
    };
  };

  systemd.services = {
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };
}

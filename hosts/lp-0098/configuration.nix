{ ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../modules/hardware/graphics.nix
    ../../modules/hardware/intel-xe.nix

    # System
    ../../modules/system/boot.nix
    ../../modules/system/fonts.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/nix.nix
    ../../modules/system/programs.nix
    ../../modules/system/users.nix

    # Services
    ../../modules/services/audio.nix
    ../../modules/services/desktop.nix
    ../../modules/services/power.nix
    ../../modules/services/podman.nix
    ../../modules/services/ssh.nix
  ];

  networking.hostName = "lp-0098";

  networking.hosts = {
    "192.168.103.189" = [ "micro-1" ];
    "192.168.103.188" = [ "micro-2" ];
    "192.168.103.187" = [ "micro-3" ];
    "192.168.103.186" = [ "micro-4" ];
  };

  services.hardware.bolt.enable = true;

  system.stateVersion = "25.05";
}

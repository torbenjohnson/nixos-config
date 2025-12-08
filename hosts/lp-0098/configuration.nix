{ pkgs, inputs, ... }:
{
  imports = [
    inputs.tactical-rmm.nixosModules.default
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
    ../../modules/services/containers.nix
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

  environment.systemPackages = with pkgs; [
    vault
    kubectl
    k9s
  ];

  services.tacticalAgent = {
    enable = true;
    apiUrl = "https://tactical-api.amotus.com";
    tokenFile = "/home/tor/nixos-config/hosts/lp-0098/rmm_token";
  };

  system.stateVersion = "25.05";
}

{ ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../modules/hardware/graphics.nix

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
    ../../modules/services/ssh.nix
  ];

  networking.hostName = "psi";

  fonts.fontconfig.subpixel = {
    rgba = "none";
    lcdfilter = "none";
  };

  system.stateVersion = "25.05";
}

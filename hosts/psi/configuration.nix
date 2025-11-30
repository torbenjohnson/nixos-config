{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../modules/hardware/graphics.nix
    ../../modules/hardware/rocm.nix

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
    ../../modules/services/podman.nix
    ../../modules/services/ssh.nix
  ];

  networking.hostName = "psi";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH port
    ];
  };

  fonts.fontconfig.subpixel = {
    rgba = "none";
    lcdfilter = "none";
  };

  programs.steam.enable = true;

  system.stateVersion = "25.05";
}

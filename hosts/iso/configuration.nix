{ pkgs, ... }:

{

  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;
  users.users.tor = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFW6A4ymM5pZqTUCiYlstpj3hfna9EsvclnDPpMKpJOi tor@eta"
    ];

    isNormalUser = true;
    description = "Torben Johnson";
    extraGroups = [ "wheel" ];
    initialPassword = "h";
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    lshw
  ];

  programs.fish.enable = true;
  services.openssh.enable = true;

  networking.hostName = "nixos";

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";
}

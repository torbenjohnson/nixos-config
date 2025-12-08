{ pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users.tor = {
      isNormalUser = true;
      description = "Torben Johnson";
      extraGroups = [
        "wheel"
        "render"
        "video"
        "audio"
        "dialout"
        "libvirtd"
        "input"
        "storage"
        "docker"
      ];
      initialPassword = "h";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8q/ckMwsbktbOk4rQnme8OPlqPVnILSCqSO/nc+FfO tor@psi"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFW6A4ymM5pZqTUCiYlstpj3hfna9EsvclnDPpMKpJOi tor@eta"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+ZBqp/rH4MlosNVibyeDlifZ7XfTXbnGTBz8XebA24 tor@lp-0098"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;
}

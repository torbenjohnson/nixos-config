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
      ];
      initialPassword = "h";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+ZBqp/rH4MlosNVibyeDlifZ7XfTXbnGTBz8XebA24 tor@psi"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+ZBqp/rH4MlosNVibyeDlifZ7XfTXbnGTBz8XebA24 tor@lp-0098"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;
}

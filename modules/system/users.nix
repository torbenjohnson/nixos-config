{ pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users.tor = {
      isNormalUser = true;
      description = "Torben Johnson";
      extraGroups = [
        "wheel"
      ];
      initialPassword = "install";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+ZBqp/rH4MlosNVibyeDlifZ7XfTXbnGTBz8XebA24 tor@psi"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;
}

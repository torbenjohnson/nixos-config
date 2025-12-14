{ lib, ... }:

{
  services = {
    # displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    printing = {
      enable = true;
      startWhenNeeded = true;
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  systemd.services = {
    bluetooth.wantedBy = lib.mkForce [ ];
    udisks2.wantedBy = lib.mkForce [ ];
  };
}

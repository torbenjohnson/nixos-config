{ lib, pkgs, ... }:

{
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    printing = {
      enable = true;
      startWhenNeeded = true;
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-cosmic ];
    config.cosmic.default = [ "cosmic" "*" ];
  };

  systemd.services = {
    bluetooth.wantedBy = lib.mkForce [ ];
    udisks2.wantedBy = lib.mkForce [ ];
  };
}

{ ... }:

{
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    printing.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

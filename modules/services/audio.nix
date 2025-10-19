{ ... }:

{
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # Required for real-time audio priority
  security.rtkit.enable = true;
}

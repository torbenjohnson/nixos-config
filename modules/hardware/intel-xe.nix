{ pkgs, ... }:

{
  boot.kernelParams = [
    "i915.force_probe=!*"
    "xe.force_probe=*"
  ];
  boot.blacklistedKernelModules = [ "i915" ];

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
    intel-gpu-tools # Intel GPU monitoring
    nvtopPackages.intel # GPU process viewer
    libva-utils # VA-API utilities
  ];
}

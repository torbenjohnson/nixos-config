{ pkgs, ... }:

{
  # boot.kernelParams = [
  #   "i915.force_probe=!*"
  #   "xe.force_probe=*"
  # ];
  # boot.blacklistedKernelModules = [ "i915" ];

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];
}

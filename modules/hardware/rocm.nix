{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL ICD
      rocmPackages.clr # Compute runtime
      rocmPackages.rocm-runtime # ROCm runtime libraries
    ];
  };

  environment.systemPackages = with pkgs; [
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    clinfo
    nvtopPackages.amd
  ];
}

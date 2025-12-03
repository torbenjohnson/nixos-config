{ pkgs }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  programs = {
    dconf.enable = true;
    virt-manager.enable = true;
  };
}

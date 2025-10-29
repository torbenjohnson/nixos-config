{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              label = "system";
              size = "100%";
              content = {
                name = "rootcrypted";
                type = "luks";
                settings = {
                  allowDiscards = true;
                  crypttabExtraOpts = [ "tpm2-device=auto" ];
                };
                extraFormatArgs = [
                  "--cipher=aes-xts-plain64"
                  "--key-size=256"
                  "--pbkdf=pbkdf2"
                  "--pbkdf-force-iterations=1000"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };

  boot.initrd.systemd.enable = true;
  security.tpm2.enable = true;

  fileSystems."/" = {
    options = [
      "noatime"
      "nodiratime"
      "commit=60"
    ];
  };

  services.fstrim.enable = true;
}

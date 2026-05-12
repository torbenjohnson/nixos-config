{
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=25"
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];
}

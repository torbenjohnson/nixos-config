{ ... }:

{
  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        USB_AUTOSUSPEND = 0;

        DISK_APM_LEVEL_ON_BAT = "128 128";
        DISK_APM_LEVEL_ON_AC = "254 254";

        WIFI_PWR_ON_BAT = "on";
        WIFI_PWR_ON_AC = "off";

        RUNTIME_PM_ON_BAT = "auto";
        RUNTIME_PM_ON_AC = "on";
      };
    };
  };
}

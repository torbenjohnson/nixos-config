{
  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "low-power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;
        PLATFORM_PROFILE_ON_BAT = "low-power";
        PLATFORM_PROFILE_ON_AC = "balanced";

        USB_AUTOSUSPEND = 1;

        WIFI_PWR_ON_BAT = "on";
        WIFI_PWR_ON_AC = "off";

        RUNTIME_PM_ON_BAT = "auto";
        RUNTIME_PM_ON_AC = "auto";
      };
    };
  };
}

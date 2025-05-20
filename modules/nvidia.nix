{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.nvidia;
in {
  options.nvidia = {
    enable = mkEnableOption "NVIDIA laptop drivers";
  };
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };

    hardware.nvidia.prime = {
      sync.enable = true;
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

}


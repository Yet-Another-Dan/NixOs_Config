{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.bluetooth;
in {
  options.bluetooth = {
    enable = mkEnableOption "enable bluetooth";
  };

  config = mkIf cfg.enable {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  };
}

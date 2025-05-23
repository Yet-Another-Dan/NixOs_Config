{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.cosmic;
in {
  options.cosmic = {
    enable = mkEnableOption "COSMIC Desktop";
  };

  config = mkIf cfg.enable {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;
  };
}


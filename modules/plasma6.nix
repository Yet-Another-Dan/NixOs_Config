{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.plasma6;
in {
  options.plasma6 = {
    enable = mkEnableOption "KDE Plasma 6 Desktop";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "extra apps to include";
    };
  };

  config = mkIf cfg.enable{
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.defaultSession = "plasma";
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
	kitty
	kdePackages.okular
	kdePackages.plasma-browser-integration
    ] ++ cfg.extraPackages;

    programs.kdeconnect.enable = true;
  };


}

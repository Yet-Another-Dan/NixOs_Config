{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.plasma6;
in {
  options.plasma6 = {
    enable = mkEnableOption "KDE Plasma 6 Desktop";

    sddmTheme = mkOption {
      type = types.str;
      default = "astronaut";
      description = "sddm theme";
    };
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
    services.displayManager.sddm.theme = "sddm-astronaut-theme";
    services.desktopManager.plasma6.enable = true;

    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      qt6.qtmultimedia
	    kdePackages.okular
	    kdePackages.plasma-browser-integration

      (pkgs.stdenv.mkDerivation {
        name = "sddm-astronaut-theme";
        src = pkgs.fetchFromGitHub {
          owner = "Keyitdev";
          repo = "sddm-astronaut-theme";
          rev = "master";
          sha256 = "sha256-33CzZ4vK1dicVzICbudk8gSRC/MExG+WnrE9wIWET14=";
        };
        installPhase = ''
          mkdir -p $out/share/sddm/themes
          cp -R $src $out/share/sddm/themes/sddm-astronaut-theme
        '';
      })
    ] ++ cfg.extraPackages;

    programs.kdeconnect.enable = true;

  };


}

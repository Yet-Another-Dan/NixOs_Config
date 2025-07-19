{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.3d_printing;
in {
  options.3d_printing = {
    enable = mkEnableOption "Enable 3d printing apps apps";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "extra apps to include";
    };
  };


  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      orca-slicer
    ] ++ cfg.extraPackages;
  };
}

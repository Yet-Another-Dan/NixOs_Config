{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.gaming;
in {
  options.gaming = {
    enable = mkEnableOption "Enable gaming apps";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "extra apps to include";
    };
  };


  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      lutris
      heroic
    ] ++ cfg.extraPackages;
  };
}

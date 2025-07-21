{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.base;
in {
  options.base = {
    enable = mkEnableOption "Baseline apps";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "extra apps to include";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;
    programs.fish.enable = true;
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [
      kitty
      git
      neovim
      tmux
      gh # github
      fastfetch
      obsidian
      spotify
    ] ++ cfg.extraPackages;

    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;

    networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];

    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
      dnsovertls = "true";
    };
  };
}

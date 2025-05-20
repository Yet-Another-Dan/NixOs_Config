{config, lib, pkgs, ...}:
with lib;

let
  cfg = config.base;
in {
  options.base = {
    enable = mkEnableOption "Baseline apps";
    extraPackages = mkOptions {
      type = types.listOf types.packages;
      default = [];
      description = "extra apps to include";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;
    programs.fish.enable = true;
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [
      git
      neovim
      tmux
      gh # github
      fastfetch
      obsidian
    ] ++ cfg.extraPackages;
  };
}

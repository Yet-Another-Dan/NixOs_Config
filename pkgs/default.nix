let
  pkgs = import <nixpkgs> {};
in
  pkgs.callPackage ./sddm-astronaut-theme.nix {}

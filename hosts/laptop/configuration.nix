# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # config.boot.loader.systemd-boot.enable = true;
  config.boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  config.boot.loader.efi.canTouchEfiVariables = true;

  config.networking.hostName = "Adeptus_Mechanicus_Auspex"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  config.nix.settings.experimental-features = ["nix-command" "flakes"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # graphics drivers
  # config.hardware.graphics.enable = true;
  
  config.nvidia.enable = true;
  
  # desktop
  config.plasma6.enable = true;
  config.cosmic.enable = false;

  # basic apps
  config.base.enable = true;

  # bluetooth
  config.bluetooth.enable = true;

  # gaming apps
  config.gaming.enable = true;

  # locale and timezone setting
  config.locale.enable = true;

  # Enable networking
  config.networking.networkmanager.enable = true;


  config.home-manager.users.dan = {
    home.stateVersion = "24.11";
    programs.fish.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  config.users.users.dan = {
    isNormalUser = true;
    description = "Dan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
    useDefaultShell = true;
  };

  # Allow unfree packages
  config.nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  config.system.stateVersion = "24.11"; # Did you read the comment?

}

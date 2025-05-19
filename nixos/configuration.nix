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
  
  config.services.xserver.videoDrivers = ["nvidia"];

  config.hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  config.hardware.nvidia.prime = {
    sync.enable = true;
    amdgpuBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  
  #desktop stuff
  # config.services.xserver.enable = true;
  # config.services.xserver.desktopManager.budgie.enable = true;
  # config.services.xserver.displayManager.lightdm.enable = true;

  config.plasma6.enable = true;

  # Enable networking
  config.networking.networkmanager.enable = true;

  # Set your time zone.
  config.time.timeZone = "America/New_York";

  # Select internationalisation properties.
  config.i18n.defaultLocale = "en_US.UTF-8";

  config.i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  config.services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  config.programs.firefox.enable = true;
  config.programs.fish.enable = true;
  config.services.flatpak.enable = true;
    

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  config.environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     git
     neovim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  config.system.stateVersion = "24.11"; # Did you read the comment?

}

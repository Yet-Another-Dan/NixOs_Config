{
  description = "Dan's NixOs config";

  inputs = {
    # Nixpkgs
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Nixpkgs unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.nixvim = {
    url = "github:nix-community/nixvim/nixos-24.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      Adeptus_Mechanicus_Auspex = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [home-manager.nixosModules.home-manager 
		   ./hosts/laptop/configuration.nix
		   ./modules/plasma6.nix 
		   ./modules/nvidia.nix
		   ./modules/base.nix
		   ./modules/gaming.nix
                   ./modules/cosmic.nix
		   ./modules/locale.nix
                   ./modules/bluetooth.nix
		   ./modules/3d_printing.nix];
      };
      Adeptus_Mechanicus_Terminal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [home-manager.nixosModules.home-manager 
		   ./hosts/desktop/configuration.nix
		   ./modules/plasma6.nix 
		   ./modules/nvidia.nix
		   ./modules/base.nix
		   ./modules/gaming.nix
                   ./modules/cosmic.nix
		   ./modules/locale.nix
		   ./modules/3d_printing.nix];
      };
    };
  };
}

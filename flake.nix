{
  description = "NixOS Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.eta = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.tor = import ./home/home.nix;
            };
          }
          ./hosts/eta/configuration.nix
        ];
      };

      nixosConfigurations.psi = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.tor = import ./home/home.nix;
            };
          }
          ./hosts/eta/configuration.nix
        ];
      };

      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./hosts/iso/configuration.nix
        ];
      };
    };
}

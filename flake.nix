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
    tactical-rmm = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://bitbucket.org/amotus/tactical-rmm-nix.git";
    };
  };
  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHost =
        hostModule:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
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
            hostModule
          ];
        };
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations = {
        eta = mkHost ./hosts/eta/configuration.nix;
        psi = mkHost ./hosts/psi/configuration.nix;
        lp-0098 = mkHost ./hosts/lp-0098/configuration.nix;

        iso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            ./hosts/iso/configuration.nix
          ];
        };
      };
    };
}

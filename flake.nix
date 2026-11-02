{
  description = "whisky's NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosModules = {
        base = import ./profiles/base.nix;
        workstation = import ./profiles/workstation.nix;
        whisky = {
          imports = [ ./users/whisky ];
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.sharedModules = [ inputs.spicetify.homeManagerModules.default ];
        };
      };

      nixosConfigurations = nixpkgs.lib.optionalAttrs (builtins.pathExists ./hosts/vm/default.nix) {
        vm = nixpkgs.lib.nixosSystem {
          modules = [
            home-manager.nixosModules.home-manager
            self.nixosModules.whisky
            ./hosts/vm
          ];
        };
      };

      formatter.${system} = pkgs.nixfmt-tree;

      devShells.${system} =
        (import ./dev {
          inherit pkgs;
          rustPkgs = import nixpkgs {
            inherit system;
            overlays = [ inputs.rust-overlay.overlays.default ];
          };
        })
        // {
          default = pkgs.mkShellNoCC {
            packages = [
              pkgs.git
              pkgs.just
              pkgs.nixfmt-tree
            ];
          };
        };
    };
}

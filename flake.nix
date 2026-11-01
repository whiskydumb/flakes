{
  description = "whisky's NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosModules = {
        base = import ./profiles/base.nix;
        workstation = import ./profiles/workstation.nix;
        whisky = import ./users/whisky;
      };

      nixosConfigurations = nixpkgs.lib.optionalAttrs (builtins.pathExists ./hosts/vm/default.nix) {
        vm = nixpkgs.lib.nixosSystem {
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/vm
          ];
        };
      };

      formatter.${system} = pkgs.nixfmt-tree;

      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = [
          pkgs.git
          pkgs.just
          pkgs.nixfmt-tree
        ];
      };
    };
}

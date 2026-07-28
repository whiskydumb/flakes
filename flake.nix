{
  description = "whisky's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    noctalia.url = "github:noctalia-dev/noctalia";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      disko,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";

      mkHost =
        host:
        lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./modules/nixos
            ./hosts/${host}

            inputs.helium.nixosModules.default
            inputs.noctalia.nixosModules.default
            inputs.sops-nix.nixosModules.sops

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = { inherit inputs self; };
              home-manager.sharedModules = [
                inputs.noctalia.homeModules.default
              ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        mochi = mkHost "mochi";
      };

      templates = {
        rust = {
          path = ./templates/rust;
          description = "Rust devshell";
        };
        node = {
          path = ./templates/node;
          description = "Node + pnpm devshell";
        };
      };
    };
}

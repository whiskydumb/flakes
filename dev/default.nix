{ pkgs, rustPkgs }:
{
  rust = import ./rust.nix { inherit pkgs rustPkgs; };
  cpp = import ./cpp.nix { inherit pkgs; };
  node = import ./node.nix { inherit pkgs; };
}

{ pkgs, rustPkgs }:
{
  rust = import ./rust.nix { inherit pkgs rustPkgs; };
  rust-windows = import ./rust.nix {
    inherit pkgs rustPkgs;
    windows = true;
  };
  cpp = import ./cpp.nix { inherit pkgs; };
  node = import ./node.nix { inherit pkgs; };
}

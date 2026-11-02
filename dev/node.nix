{ pkgs }:
let
  node = pkgs.nodejs_26;
in
pkgs.mkShell {
  name = "node";
  packages = [
    node
    (pkgs.pnpm.override { nodejs-slim = node; })
    pkgs.python3
    pkgs.pkg-config
    pkgs.just
  ];
}

set positional-arguments

default:
    @just --list

fmt:
    nix fmt -- --tree-root .

check:
    nix fmt -- --tree-root . --ci
    nix flake check --no-build --show-trace

build host="vm":
    nix build "path:.#nixosConfigurations.$1.config.system.build.toplevel" --no-link --print-out-paths

switch host="vm":
    sudo nixos-rebuild switch --flake "path:.#$1"

update:
    nix flake update

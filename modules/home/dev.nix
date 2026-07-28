{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    cmake

    python3
    uv

    nodejs
    pnpm

    go

    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer

    godot

    claude-code
  ];
}
